import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_router/go_router.dart';

import 'package:jdonut/app.dart';
import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/l10n/locale_controller.dart';
import 'package:jdonut/core/router/app_routes.dart';
import 'package:jdonut/core/session/auth_session.dart';
import 'package:jdonut/features/auth/presentation/pages/onboarding_page.dart';
import 'package:jdonut/features/settings/presentation/pages/settings_page.dart';
import 'package:jdonut/features/settings/presentation/widgets/settings_profile_header.dart';

void main() {
  late AuthSession session;

  setUp(() => session = getIt.registerSingleton(AuthSession()..signIn()));
  tearDown(getIt.reset);

  Future<void> openSettings(WidgetTester tester) async {
    await tester.pumpWidget(JDonutApp(session: session, localeController: getIt.registerSingleton(LocaleController())));
    await tester.pumpAndSettle();
    GoRouter.of(tester.element(find.byType(Navigator).first)).go(AppRoutes.settings);
    await tester.pumpAndSettle();
  }

  Finder settingsList() => find.descendant(of: find.byType(SettingsPage), matching: find.byType(Scrollable)).first;

  /// Scrolls [target] to mid-screen so the floating bottom nav bar can't cover it.
  Future<void> scrollToCenter(WidgetTester tester, Finder target) async {
    await tester.scrollUntilVisible(target, 200, scrollable: settingsList());
    await Scrollable.ensureVisible(tester.element(target), alignment: 0.5);
    await tester.pumpAndSettle();
  }

  testWidgets('choosing မြန်မာ switches the whole app to Burmese', (tester) async {
    await openSettings(tester);

    await scrollToCenter(tester, find.text('Language'));
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('မြန်မာ'));
    await tester.pumpAndSettle();

    expect(find.text('ဘာသာစကား'), findsOneWidget);
    expect(find.text('Language'), findsNothing);
  });

  testWidgets('profile header scrolls away, then floats back on a small upward scroll', (tester) async {
    await openSettings(tester);
    final header = find.byType(SettingsProfileHeader);
    expect(header.hitTestable(), findsOneWidget);

    await tester.drag(settingsList(), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(header.hitTestable(), findsNothing);

    await tester.drag(settingsList(), const Offset(0, 120));
    await tester.pumpAndSettle();
    expect(header.hitTestable(), findsOneWidget);
  });

  testWidgets('confirming log out returns to onboarding', (tester) async {
    await openSettings(tester);

    final logOutRow = find.widgetWithText(ListTile, 'Log out');
    await scrollToCenter(tester, logOutRow);
    await tester.tap(logOutRow);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Log out'));
    await tester.pumpAndSettle();

    expect(session.isSignedIn, isFalse);
    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('cancelling log out keeps the user signed in', (tester) async {
    await openSettings(tester);

    final logOutRow = find.widgetWithText(ListTile, 'Log out');
    await scrollToCenter(tester, logOutRow);
    await tester.tap(logOutRow);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(session.isSignedIn, isTrue);
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
