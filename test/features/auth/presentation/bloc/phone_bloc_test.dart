import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/submission_status.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/router/app_routes.dart';
import 'package:jdonut/features/auth/domain/usecases/check_phone_registered_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/send_otp_use_case.dart';
import 'package:jdonut/features/auth/domain/validators/phone_validator.dart';
import 'package:jdonut/features/auth/presentation/bloc/phone/phone_bloc.dart';

class _MockCheckPhoneRegistered extends Mock implements CheckPhoneRegisteredUseCase {}

class _MockSendOtp extends Mock implements SendOtpUseCase {}

const _phone = '+959254135592';
const _typed = '09254135592';

/// Answers like a real call would: a moment later, so a second tap arrives mid-request.
Future<T> _afterNetworkDelay<T>(T value) => Future.delayed(const Duration(milliseconds: 50), () => value);

void main() {
  late _MockCheckPhoneRegistered checkPhoneRegistered;
  late _MockSendOtp sendOtp;

  setUp(() {
    checkPhoneRegistered = _MockCheckPhoneRegistered();
    sendOtp = _MockSendOtp();
    when(() => sendOtp(_phone)).thenAnswer((_) async => const Right(unit));
  });

  PhoneBloc build() => PhoneBloc(checkPhoneRegistered, sendOtp);

  group('validation', () {
    test('Continue is disabled until the number is valid', () {
      expect(const PhoneState(input: '0925').canSubmit, isFalse);
      expect(const PhoneState(input: _typed).canSubmit, isTrue);
    });

    blocTest<PhoneBloc, PhoneState>(
      'hides the error while typing and shows it once the field loses focus',
      build: build,
      act: (bloc) => bloc
        ..add(const PhoneChanged('0925'))
        ..add(const PhoneFocusLost()),
      verify: (bloc) => expect(bloc.state.visibleError, PhoneError.invalidFormat),
    );

    blocTest<PhoneBloc, PhoneState>(
      'does not show an error when an empty field loses focus',
      build: build,
      act: (bloc) => bloc.add(const PhoneFocusLost()),
      verify: (bloc) => expect(bloc.state.visibleError, isNull),
    );
  });

  group('submit', () {
    blocTest<PhoneBloc, PhoneState>(
      'sign-up sends a code without checking registration',
      build: build,
      seed: () => const PhoneState(input: _typed),
      act: (bloc) => bloc.add(const PhoneSubmitted()),
      expect: () => [
        const PhoneState(input: _typed, status: SubmissionStatus.submitting),
        const PhoneState(input: _typed, status: SubmissionStatus.success),
      ],
      verify: (_) => verifyNever(() => checkPhoneRegistered(any())),
    );

    blocTest<PhoneBloc, PhoneState>(
      'log in with an unregistered number fails with notRegistered and sends no code',
      setUp: () => when(() => checkPhoneRegistered(_phone)).thenAnswer((_) async => const Right(false)),
      build: build,
      seed: () => const PhoneState(flow: AuthFlow.login, input: _typed),
      act: (bloc) => bloc.add(const PhoneSubmitted()),
      verify: (bloc) {
        expect(bloc.state.status, SubmissionStatus.failure);
        expect(bloc.state.submitError, PhoneSubmitError.notRegistered);
        verifyNever(() => sendOtp(any()));
      },
    );

    blocTest<PhoneBloc, PhoneState>(
      'log in with a registered number sends a code',
      setUp: () => when(() => checkPhoneRegistered(_phone)).thenAnswer((_) async => const Right(true)),
      build: build,
      seed: () => const PhoneState(flow: AuthFlow.login, input: _typed),
      act: (bloc) => bloc.add(const PhoneSubmitted()),
      verify: (bloc) => expect(bloc.state.status, SubmissionStatus.success),
    );

    blocTest<PhoneBloc, PhoneState>(
      'a failed send shows the generic error',
      setUp: () => when(() => sendOtp(_phone)).thenAnswer((_) async => const Left(ServerFailure('down', null))),
      build: build,
      seed: () => const PhoneState(input: _typed),
      act: (bloc) => bloc.add(const PhoneSubmitted()),
      verify: (bloc) => expect(bloc.state.submitError, PhoneSubmitError.unknown),
    );

    blocTest<PhoneBloc, PhoneState>(
      'a double tap on Continue sends only one request',
      setUp: () => when(() => sendOtp(_phone)).thenAnswer((_) => _afterNetworkDelay(const Right(unit))),
      build: build,
      seed: () => const PhoneState(input: _typed),
      act: (bloc) => bloc
        ..add(const PhoneSubmitted())
        ..add(const PhoneSubmitted()),
      verify: (_) => verify(() => sendOtp(_phone)).called(1),
    );

    blocTest<PhoneBloc, PhoneState>(
      'Create an account switches to sign-up and keeps the number',
      build: build,
      seed: () => const PhoneState(
        flow: AuthFlow.login,
        input: _typed,
        status: SubmissionStatus.failure,
        submitError: PhoneSubmitError.notRegistered,
      ),
      act: (bloc) => bloc.add(const PhoneRegisterInsteadTapped()),
      expect: () => [const PhoneState(input: _typed)],
    );
  });
}
