import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/widgets/pill_tab_bar.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';
import 'package:jdonut/features/rewards/presentation/pages/rewards_page.dart';

import '../test/helpers/auth_flow_actions.dart';
import '../test/helpers/pump_until.dart';
import '../test/helpers/test_app.dart';

/// Frame timings for the animated path from the first screen to Rewards.
///
/// Run on a real mid-range Android phone in profile mode (see README):
///   flutter drive --profile --no-dds --driver=test_driver/perf_driver.dart --target=integration_test/perf_test.dart
/// (`--no-dds` lets the test connect to the VM service to record the timeline.)
/// The driver writes the summary to build/ and fails if frames miss the 60 fps budget.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  tearDown(getIt.reset);

  testWidgets('Onboarding → Registration → Welcome → Home → Rewards keeps 60 fps', (tester) async {
    await pumpJDonutApp(tester);

    await binding.watchPerformance(() async {
      await _register(tester);
      await _browseHome(tester);
      await _browseRewards(tester);
    }, reportKey: perfReportKey);
  });
}

/// Key of this run in the driver's report.
const String perfReportKey = 'onboarding_to_rewards';

Future<void> _register(WidgetTester tester) async {
  await tester.tapLabel("LET'S GET STARTED");
  await tester.enterPhone(testPhoneInput);
  await tester.tapLabel('CONTINUE');
  await tester.enterOtp();
  await tester.enterTextInField(hint: 'First Name', text: 'Hania');
  await tester.tapLabel('CONTINUE');
  await tester.pickDefaultBirthDate();
  await tester.tapLabel('CONTINUE');
  await tester.tapLabel("LET'S EXPLORE");
  await tester.pumpUntilFound(find.byType(HomePage));
  expect(find.byType(HomePage), findsOneWidget);
}

/// Scrolls Home down and back up while sections and the carousel animate.
Future<void> _browseHome(WidgetTester tester) async {
  final homeList = find.descendant(of: find.byType(HomePage), matching: find.byType(Scrollable)).first;
  await tester.fling(homeList, const Offset(0, -600), 1500);
  await tester.pumpAndSettle();
  await tester.fling(homeList, const Offset(0, 600), 1500);
  await tester.pumpAndSettle();
}

/// Opens Rewards (ring, ladder, cards), switches tabs and back, and scrolls.
Future<void> _browseRewards(WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel('Rewards').last);
  await tester.pumpUntilFound(find.byType(RewardsPage));
  expect(find.byType(RewardsPage), findsOneWidget);

  await tester.tap(find.byKey(PillTabBar.tabKey(1)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(PillTabBar.tabKey(0)));
  await tester.pumpAndSettle();

  final rewardsList = find.descendant(of: find.byType(RewardsPage), matching: find.byType(Scrollable)).first;
  await tester.fling(rewardsList, const Offset(0, -500), 1500);
  await tester.pumpAndSettle();
}
