import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/router/app_routes.dart';
import 'package:jdonut/core/widgets/offline_banner.dart';

import '../../../../helpers/fakes.dart';
import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('opens a product in airplane mode from the local database', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true, network: FakeNetworkInfo(isOnline: false));

    routerOf(tester).push(AppRoutes.productDetail('p_coconut'));
    await tester.pumpAndSettle();

    expect(find.text('Coconut Donut'), findsOneWidget);
    expect(find.text('3,200 MMK'), findsWidgets);
    expect(find.byKey(OfflineBanner.bannerKey), findsOneWidget);
  });

  testWidgets('changing the quantity updates the total', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);
    routerOf(tester).push(AppRoutes.productDetail('p_coconut'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byTooltip('Increase quantity'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Increase quantity'));
    await tester.pumpAndSettle();

    expect(find.text('6,400 MMK'), findsOneWidget);
  });

  testWidgets('an unknown product id shows the not-found message', (tester) async {
    await pumpJDonutApp(tester, isSignedIn: true);

    routerOf(tester).push(AppRoutes.productDetail('p_missing'));
    await tester.pumpAndSettle();

    expect(find.text("We couldn't find this donut."), findsOneWidget);
  });
}
