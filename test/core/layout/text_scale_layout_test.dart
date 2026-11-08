import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/router/app_routes.dart';

import '../../helpers/test_app.dart';

/// Smallest (4.7") and largest (6.9") portrait phones in logical pixels.
const _screens = {'4.7 inch': Size(320, 568), '6.9 inch': Size(440, 956)};
const double _maxTextScale = 1.3;

final _signedOutRoutes = [
  AppRoutes.onboarding,
  AppRoutes.phoneFor(AuthFlow.register),
  AppRoutes.otp,
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

    await pumpJDonutApp(tester, isSignedIn: signedIn);
    routerOf(tester).go(route);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull, reason: '$route overflowed');
    await unmountApp(tester);
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
