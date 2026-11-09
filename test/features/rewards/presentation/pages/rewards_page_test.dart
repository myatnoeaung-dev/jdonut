import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/router/app_routes.dart';
import 'package:jdonut/core/widgets/pill_tab_bar.dart';
import 'package:jdonut/features/rewards/presentation/widgets/challenge_card.dart';

import '../../../../helpers/test_app.dart';

void main() {
  tearDown(getIt.reset);

  Future<void> openRewards(WidgetTester tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);
    routerOf(tester).go(AppRoutes.rewards);
    await tester.pumpAndSettle();
  }

  FilledButton earnButton(WidgetTester tester, String challengeId) => tester.widget<FilledButton>(
    find.descendant(of: find.byKey(ChallengeCard.earnButtonKey(challengeId)), matching: find.byType(FilledButton)),
  );

  testWidgets('shows the member tier ladder and total points from the local record', (tester) async {
    await openRewards(tester);

    expect(find.text("J' Donuts Rewards"), findsOneWidget);
    expect(find.text("You're here now"), findsOneWidget);
    expect(find.text('1,290 pts remaining to become Gold'), findsOneWidget);
    expect(find.text("You'll be here soon"), findsOneWidget);
    expect(find.bySemanticsLabel('Total points 680,000'), findsOneWidget);
  });

  testWidgets('EARN is enabled only for completed challenges', (tester) async {
    // Tall enough that the first cards are built without scrolling.
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 1400);
    addTearDown(tester.view.reset);
    await openRewards(tester);

    expect(earnButton(tester, 'c_coco_4_done').onPressed, isNotNull);
    expect(earnButton(tester, 'c_coco_4').onPressed, isNull);
  });

  testWidgets('the rewards pill counts the challenges ready to claim', (tester) async {
    await openRewards(tester);

    expect(find.bySemanticsLabel('3 rewards ready to claim'), findsOneWidget);
  });

  testWidgets('tapping Gift switches to the gift tab', (tester) async {
    await openRewards(tester);

    await tester.tap(find.byKey(PillTabBar.tabKey(1)));
    await tester.pumpAndSettle();

    expect(find.text('Design coming soon'), findsOneWidget);
    expect(find.byKey(ChallengeCard.earnButtonKey('c_coco_4_done')), findsNothing);
  });
}
