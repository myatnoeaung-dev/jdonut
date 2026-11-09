import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/widgets/app_bottom_nav_bar.dart';
import 'package:jdonut/core/widgets/coming_soon_page.dart';
import 'package:jdonut/features/auth/presentation/pages/onboarding_page.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';
import 'package:jdonut/features/product/presentation/pages/product_detail_page.dart';

import '../../helpers/test_app.dart';

void main() {
  tearDown(getIt.reset);

  testWidgets('starts on onboarding when signed out', (tester) async {
    await pumpJDonutApp(tester);

    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('relaunching while signed in opens home', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('a signed-out deep link to a product redirects to onboarding', (tester) async {
    await pumpJDonutApp(tester);

    routerOf(tester).go('/product/p_coconut');
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailPage), findsNothing);
    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('bottom nav switches tabs and shows placeholders for undesigned ones', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);

    // Guards against the bar stretching to fill the screen and hiding the page.
    expect(tester.getSize(find.byType(AppBottomNavBar)).height, lessThan(120));

    await tester.tap(find.bySemanticsLabel('Wallet'));
    await tester.pumpAndSettle();
    expect(find.byType(ComingSoonPage), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('tapping a product on home opens /product/:id', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);

    // "Order again" is below the fold of a lazily built list, so scroll until it exists.
    final coconutTile = find.byKey(HomePage.productCardKey('p_coconut'));
    final homeList = find.descendant(of: find.byType(HomePage), matching: find.byType(Scrollable)).first;
    await tester.scrollUntilVisible(coconutTile, 200, scrollable: homeList);
    await tester.ensureVisible(coconutTile);
    await tester.pumpAndSettle();
    await tester.tap(coconutTile);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Mid-transition: the photo is in flight between two heroes.
    expect(find.byType(Hero), findsWidgets);
    await tester.pumpAndSettle();

    final detail = tester.widget<ProductDetailPage>(find.byType(ProductDetailPage));
    expect(detail.productId, 'p_coconut');
    // Tagged with the section the tile was in, so the same product in two sections never clashes.
    expect(detail.heroTag, matches(RegExp(r'^product_\w+_p_coconut$')));
  });
}
