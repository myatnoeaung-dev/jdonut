import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:jdonut/features/auth/presentation/pages/birth_date_page.dart';
import 'package:jdonut/features/auth/presentation/pages/name_page.dart';
import 'package:jdonut/features/auth/presentation/pages/phone_number_page.dart';
import 'package:jdonut/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';
import 'package:jdonut/features/home/presentation/pages/welcome_page.dart';

import '../../../../helpers/auth_flow_actions.dart';
import '../../../../helpers/test_app.dart';

void main() {
  tearDown(getIt.reset);

  group('Let\'s get started', () {
    testWidgets('a new number goes phone → OTP → name → date of birth → welcome → home', (tester) async {
      await pumpJDonutApp(tester);

      await tester.tapLabel("LET'S GET STARTED");
      await tester.enterPhone(testPhoneInput);
      await tester.tapLabel('CONTINUE');
      expect(find.byType(VerifyOtpPage), findsOneWidget);
      expect(find.textContaining(testPhoneNumber), findsOneWidget);

      await tester.enterOtp();
      expect(find.byType(NamePage), findsOneWidget);

      await tester.enterTextInField(hint: 'First Name', text: 'Hania');
      await tester.tapLabel('CONTINUE');
      expect(find.byType(BirthDatePage), findsOneWidget);

      await tester.pickDefaultBirthDate();
      await tester.tapLabel('CONTINUE');
      expect(find.byType(WelcomePage), findsOneWidget);
      expect(getIt<AuthBloc>().state, isA<Authenticated>());

      await tester.tapLabel("LET'S EXPLORE");
      expect(find.byType(HomePage), findsOneWidget);
      await unmountApp(tester);
    });

    testWidgets('an already registered number goes straight home after the OTP', (tester) async {
      await pumpJDonutApp(tester, isRegistered: true);

      await tester.tapLabel("LET'S GET STARTED");
      await tester.enterPhone(testPhoneInput);
      await tester.tapLabel('CONTINUE');
      await tester.enterOtp();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NamePage), findsNothing);
      await unmountApp(tester);
    });
  });

  group('Log in', () {
    testWidgets('a registered number goes phone → OTP → home', (tester) async {
      await pumpJDonutApp(tester, isRegistered: true);

      await tester.tapLinkText('Log in');
      await tester.enterPhone(testPhoneInput);
      await tester.tapLabel('CONTINUE');
      await tester.enterOtp();

      expect(find.byType(HomePage), findsOneWidget);
      await unmountApp(tester);
    });

    testWidgets('an unregistered number shows an inline message with a link to register', (tester) async {
      await pumpJDonutApp(tester);

      await tester.tapLinkText('Log in');
      await tester.enterPhone(testPhoneInput);
      await tester.tapLabel('CONTINUE');

      expect(find.byType(PhoneNumberPage), findsOneWidget);
      expect(find.textContaining("This number isn't registered yet."), findsOneWidget);

      await tester.tapLinkText('Create an account');
      expect(find.textContaining("This number isn't registered yet."), findsNothing);

      await tester.tapLabel('CONTINUE');
      await tester.enterOtp();
      expect(find.byType(NamePage), findsOneWidget, reason: 'the kept number continues as a sign-up');
      await unmountApp(tester);
    });
  });

  group('OTP', () {
    Future<void> openOtp(WidgetTester tester) async {
      await pumpJDonutApp(tester);
      await tester.tapLabel("LET'S GET STARTED");
      await tester.enterPhone(testPhoneInput);
      await tester.tapLabel('CONTINUE');
    }

    testWidgets('a wrong code shows how many tries are left', (tester) async {
      await openOtp(tester);

      await tester.enterOtp('000000');

      expect(find.text('Wrong code. 2 tries left.'), findsOneWidget);
      expect(find.byType(VerifyOtpPage), findsOneWidget);
      await unmountApp(tester);
    });

    testWidgets('three wrong codes lock entry until a new code is sent', (tester) async {
      await openOtp(tester);

      for (var attempt = 0; attempt < 3; attempt++) {
        await tester.enterOtp('000000');
      }

      expect(find.text('Too many wrong codes. Request a new code to try again.'), findsOneWidget);
      await unmountApp(tester);
    });
  });

  testWidgets('Back from the OTP step keeps the typed phone number', (tester) async {
    await pumpJDonutApp(tester);
    await tester.tapLabel("LET'S GET STARTED");
    await tester.enterPhone(testPhoneInput);
    await tester.tapLabel('CONTINUE');

    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();

    expect(find.byType(PhoneNumberPage), findsOneWidget);
    expect(find.text(testPhoneInput), findsOneWidget);
    await unmountApp(tester);
  });
}
