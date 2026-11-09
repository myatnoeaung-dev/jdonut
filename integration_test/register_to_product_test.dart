import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';
import 'package:jdonut/features/home/presentation/pages/welcome_page.dart';
import 'package:jdonut/features/product/presentation/pages/product_detail_page.dart';

import '../test/helpers/auth_flow_actions.dart';
import '../test/helpers/pump_until.dart';
import '../test/helpers/test_app.dart';

/// End to end on a device: sign up with a new number, land on Home and open a
/// product. Uses the fake auth backend and an in-memory database.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  tearDown(getIt.reset);

  testWidgets('Register → Home → Product detail', (tester) async {
    await pumpJDonutApp(tester);

    await tester.tapLabel("LET'S GET STARTED");
    await tester.enterPhone(testPhoneInput);
    await tester.tapLabel('CONTINUE');
    await tester.enterOtp();
    await tester.enterTextInField(hint: 'First Name', text: 'Hania');
    await tester.tapLabel('CONTINUE');
    await tester.pickDefaultBirthDate();
    await tester.tapLabel('CONTINUE');
    await tester.pumpUntilFound(find.byType(WelcomePage));
    expect(find.byType(WelcomePage), findsOneWidget);

    await tester.tapLabel("LET'S EXPLORE");
    await tester.pumpUntilFound(find.byType(HomePage));
    expect(find.byType(HomePage), findsOneWidget);

    final coconutTile = find.byKey(HomePage.productCardKey('p_coconut'));
    final homeList = find.descendant(of: find.byType(HomePage), matching: find.byType(Scrollable)).first;
    await tester.scrollUntilVisible(coconutTile, 200, scrollable: homeList);
    await tester.ensureVisible(coconutTile);
    await tester.pumpAndSettle();
    await tester.tap(coconutTile);
    await tester.pumpAndSettle();

    expect(tester.widget<ProductDetailPage>(find.byType(ProductDetailPage)).productId, 'p_coconut');
  });
}
