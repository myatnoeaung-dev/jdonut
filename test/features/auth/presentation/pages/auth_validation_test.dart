import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/features/auth/data/auth_config.dart';
import 'package:jdonut/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:jdonut/features/auth/presentation/pages/birth_date_page.dart';
import 'package:jdonut/features/auth/presentation/pages/name_page.dart';
import 'package:jdonut/features/auth/presentation/pages/verify_otp_page.dart';

import '../../../../helpers/auth_flow_actions.dart';
import '../../../../helpers/test_app.dart';

void main() {
  tearDown(getIt.reset);

  Future<void> openPhoneStep(WidgetTester tester, {Duration fakeLatency = Duration.zero}) async {
    await pumpJDonutApp(tester, fakeLatency: fakeLatency);
    await tester.tapLabel("LET'S GET STARTED");
  }

  Future<void> openNameStep(WidgetTester tester) async {
    await openPhoneStep(tester);
    await tester.enterPhone(testPhoneInput);
    await tester.tapLabel('CONTINUE');
    await tester.enterOtp();
  }

  group('phone step', () {
    testWidgets('CONTINUE stays disabled until the number is valid', (tester) async {
      await openPhoneStep(tester);

      await tester.enterPhone('0925');
      expect(tester.isButtonEnabled('CONTINUE'), isFalse);

      await tester.enterPhone('09 254 135 592');
      expect(tester.isButtonEnabled('CONTINUE'), isTrue);
      await unmountApp(tester);
    });

    testWidgets('shows the inline message only after the field loses focus', (tester) async {
      await openPhoneStep(tester);
      const message = 'Enter a valid Myanmar mobile number, e.g. 09 254 135 592.';

      await tester.enterPhone('0925');
      expect(find.text(message), findsNothing);

      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();
      expect(find.text(message), findsOneWidget);
      await unmountApp(tester);
    });

    testWidgets('CONTINUE shows a spinner during the fake call, then opens the OTP step', (tester) async {
      await openPhoneStep(tester, fakeLatency: AuthConfig.fakeLatency);
      await tester.enterPhone(testPhoneInput);

      await tester.tap(find.text('CONTINUE'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(AuthConfig.fakeLatency);
      expect(find.byType(VerifyOtpPage), findsOneWidget);
      await unmountApp(tester);
    });
  });

  group('name step', () {
    testWidgets('an empty first name shows "Enter your first name."', (tester) async {
      await openNameStep(tester);

      await tester.tapLabel('CONTINUE');

      expect(find.text('Enter your first name.'), findsOneWidget);
      expect(find.byType(NamePage), findsOneWidget);
      await unmountApp(tester);
    });

    testWidgets('digits in a name show "Use letters and spaces only."', (tester) async {
      await openNameStep(tester);

      await tester.enterTextInField(hint: 'First Name', text: 'Hania2');
      await tester.tapLabel('CONTINUE');

      expect(find.text('Use letters and spaces only.'), findsOneWidget);
      await unmountApp(tester);
    });

    testWidgets('Back from date of birth keeps the entered name', (tester) async {
      await openNameStep(tester);
      await tester.enterTextInField(hint: 'First Name', text: 'Ye Min');
      await tester.tapLabel('CONTINUE');
      expect(find.byType(BirthDatePage), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Ye Min'), findsOneWidget);
      await unmountApp(tester);
    });
  });

  group('date of birth step', () {
    Future<void> openBirthDateStep(WidgetTester tester) async {
      await openNameStep(tester);
      await tester.enterTextInField(hint: 'First Name', text: 'Hania');
      await tester.tapLabel('CONTINUE');
    }

    testWidgets('CONTINUE is disabled until a date is picked', (tester) async {
      await openBirthDateStep(tester);

      expect(tester.isButtonEnabled('CONTINUE'), isFalse);

      await tester.pickDefaultBirthDate();
      expect(tester.isButtonEnabled('CONTINUE'), isTrue);
      await unmountApp(tester);
    });

    testWidgets('someone younger than 13 sees an inline message and cannot continue', (tester) async {
      await openBirthDateStep(tester);
      final today = DateTime.now();

      tester
          .element(find.byType(BirthDatePage))
          .read<ProfileBloc>()
          .add(ProfileBirthDateChanged(DateTime(today.year - 5, today.month, today.day)));
      await tester.pumpAndSettle();

      expect(find.text('You must be at least 13 years old.'), findsOneWidget);
      expect(tester.isButtonEnabled('CONTINUE'), isFalse);
      await unmountApp(tester);
    });
  });
}
