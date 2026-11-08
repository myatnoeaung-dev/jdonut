import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_router/go_router.dart';

import 'package:jdonut/app.dart';
import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/session/auth_session.dart';
import 'package:jdonut/features/auth/presentation/pages/birth_date_page.dart';
import 'package:jdonut/features/auth/presentation/pages/name_page.dart';
import 'package:jdonut/features/auth/presentation/pages/onboarding_page.dart';
import 'package:jdonut/features/auth/presentation/pages/phone_number_page.dart';
import 'package:jdonut/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:jdonut/features/auth/presentation/widgets/otp_code_field.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';
import 'package:jdonut/features/home/presentation/pages/welcome_page.dart';
import 'package:jdonut/features/home/presentation/widgets/product_preview_row.dart';
import 'package:jdonut/features/product/presentation/pages/product_detail_page.dart';

void main() {
  late AuthSession session;

  setUp(() => session = getIt.registerSingleton(AuthSession()));
  tearDown(getIt.reset);

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(JDonutApp(session: session));
    await tester.pumpAndSettle();
  }

  /// Unmounts the app so the OTP resend timer doesn't outlive the test.
  Future<void> unmount(WidgetTester tester) => tester.pumpWidget(const SizedBox());

  GoRouter routerOf(WidgetTester tester) => GoRouter.of(tester.element(find.byType(Navigator).first));

  Future<void> tapButton(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.text(label));
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }

  Future<void> enterOtp(WidgetTester tester) async {
    final otpInput = find.descendant(of: find.byType(OtpCodeField), matching: find.byType(TextField));
    await tester.enterText(otpInput, '123456');
    await tester.pumpAndSettle();
  }

  testWidgets('starts on onboarding when signed out', (tester) async {
    await pumpApp(tester);

    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('registration goes phone → OTP → name → date of birth → welcome → home', (tester) async {
    await pumpApp(tester);

    await tapButton(tester, "LET'S GET STARTED");
    expect(find.byType(PhoneNumberPage), findsOneWidget);

    await tester.enterText(find.byType(TextField), '09254135592');
    await tapButton(tester, 'CONTINUE');
    expect(find.byType(VerifyOtpPage), findsOneWidget);
    expect(find.textContaining('+9509254135592'), findsOneWidget);

    await enterOtp(tester);
    expect(find.byType(NamePage), findsOneWidget);

    await tapButton(tester, 'CONTINUE');
    expect(find.byType(BirthDatePage), findsOneWidget);

    await tapButton(tester, 'CONTINUE');
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(session.isSignedIn, isTrue);

    await tapButton(tester, "LET'S EXPLORE");
    expect(find.byType(HomePage), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('log in goes from OTP straight to home', (tester) async {
    await pumpApp(tester);

    await tester.tapOnText(find.textRange.ofSubstring('Log in'));
    await tester.pumpAndSettle();
    await tapButton(tester, 'CONTINUE');
    await enterOtp(tester);

    expect(find.byType(HomePage), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('a signed-out deep link to a product redirects to onboarding', (tester) async {
    await pumpApp(tester);

    routerOf(tester).go('/product/p_coconut');
    await tester.pumpAndSettle();

    expect(find.byType(ProductDetailPage), findsNothing);
    expect(find.byType(OnboardingPage), findsOneWidget);
  });

  testWidgets('a signed-in user is sent home instead of onboarding', (tester) async {
    session.signIn();
    await pumpApp(tester);

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('tapping a product on home opens /product/:id', (tester) async {
    session.signIn();
    await pumpApp(tester);

    final coconutTile = find.byKey(ProductPreviewRow.tileKey('p_coconut')).first;
    await tester.ensureVisible(coconutTile);
    await tester.pumpAndSettle();
    await tester.tap(coconutTile);
    await tester.pumpAndSettle();

    final detail = tester.widget<ProductDetailPage>(find.byType(ProductDetailPage));
    expect(detail.productId, 'p_coconut');
  });
}
