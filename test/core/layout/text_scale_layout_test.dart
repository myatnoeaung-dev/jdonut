import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_router/go_router.dart';

import 'package:jdonut/app.dart';
import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/l10n/locale_controller.dart';
import 'package:jdonut/core/router/app_routes.dart';
import 'package:jdonut/core/session/auth_session.dart';

/// Smallest (4.7") and largest (6.9") portrait phones in logical pixels.
const _screens = {'4.7 inch': Size(320, 568), '6.9 inch': Size(440, 956)};
const double _maxTextScale = 1.3;

final _signedOutRoutes = [
  AppRoutes.onboarding,
  AppRoutes.phoneFor(AuthFlow.register),
  AppRoutes.otpFor(AuthFlow.register, '+959254135592'),
  AppRoutes.name,
  AppRoutes.birthDate,
];

final _signedInRoutes = [
  AppRoutes.welcome,
  AppRoutes.home,
  AppRoutes.rewards,
  AppRoutes.menu,
  AppRoutes.wallet,
  AppRoutes.settings,
  AppRoutes.productDetail('p_coconut'),
];

void main() {
  tearDown(getIt.reset);

  Future<void> expectNoOverflow(WidgetTester tester, Size screen, String route, {required bool signedIn}) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = screen;
    tester.platformDispatcher.textScaleFactorTestValue = _maxTextScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    final session = getIt.registerSingleton(AuthSession());
    if (signedIn) session.signIn();
    await tester.pumpWidget(JDonutApp(session: session, localeController: getIt.registerSingleton(LocaleController())));
    GoRouter.of(tester.element(find.byType(Navigator).first)).go(route);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull, reason: '$route overflowed');
    await tester.pumpWidget(const SizedBox());
    await getIt.reset();
  }

  for (final MapEntry(key: name, value: screen) in _screens.entries) {
    testWidgets('signed-out screens fit a $name phone at text scale 1.3', (tester) async {
      for (final route in _signedOutRoutes) {
        await expectNoOverflow(tester, screen, route, signedIn: false);
      }
    });

    testWidgets('signed-in screens fit a $name phone at text scale 1.3', (tester) async {
      for (final route in _signedInRoutes) {
        await expectNoOverflow(tester, screen, route, signedIn: true);
      }
    });
  }
}
