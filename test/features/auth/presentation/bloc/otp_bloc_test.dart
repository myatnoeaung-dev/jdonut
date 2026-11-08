import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/submission_status.dart';
import 'package:jdonut/core/time/countdown_ticker.dart';
import 'package:jdonut/features/auth/domain/entities/otp_outcome.dart';
import 'package:jdonut/features/auth/domain/entities/user.dart';
import 'package:jdonut/features/auth/domain/failures/auth_failures.dart';
import 'package:jdonut/features/auth/domain/usecases/send_otp_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:jdonut/features/auth/presentation/bloc/otp/otp_bloc.dart';

class _MockVerifyOtp extends Mock implements VerifyOtpUseCase {}

class _MockSendOtp extends Mock implements SendOtpUseCase {}

/// Finishes the countdown immediately, so Resend is available in tests.
class _InstantTicker implements CountdownTicker {
  @override
  Stream<int> countdown(int fromSeconds) => Stream.value(0);
}

/// Never ticks: the countdown stays at 5:00.
class _FrozenTicker implements CountdownTicker {
  @override
  Stream<int> countdown(int fromSeconds) => const Stream.empty();
}

const _phone = '+959254135592';
const _params = VerifyOtpParams(phoneNumber: _phone, code: '123456');
final _user = User(id: '1', phoneNumber: _phone, firstName: 'Hania', lastName: null, birthDate: DateTime(1995, 5, 1));

void main() {
  late _MockVerifyOtp verifyOtp;
  late _MockSendOtp sendOtp;

  setUpAll(() => registerFallbackValue(_params));

  setUp(() {
    verifyOtp = _MockVerifyOtp();
    sendOtp = _MockSendOtp();
    when(() => sendOtp(_phone)).thenAnswer((_) async => const Right(unit));
  });

  OtpBloc build([CountdownTicker? ticker]) => OtpBloc(verifyOtp, sendOtp, ticker ?? _FrozenTicker());

  blocTest<OtpBloc, OtpState>(
    'a correct code for a member ends in signedIn',
    setUp: () => when(() => verifyOtp(_params)).thenAnswer((_) async => Right(OtpSignedIn(_user))),
    build: build,
    seed: () => const OtpState(phoneNumber: _phone),
    act: (bloc) => bloc.add(const OtpCodeCompleted('123456')),
    expect: () => [
      const OtpState(phoneNumber: _phone, status: SubmissionStatus.submitting),
      const OtpState(phoneNumber: _phone, status: SubmissionStatus.success, outcome: OtpOutcomeKind.signedIn),
    ],
  );

  blocTest<OtpBloc, OtpState>(
    'a correct code for a new number ends in needsRegistration',
    setUp: () => when(() => verifyOtp(_params)).thenAnswer((_) async => const Right(OtpNeedsRegistration())),
    build: build,
    seed: () => const OtpState(phoneNumber: _phone),
    act: (bloc) => bloc.add(const OtpCodeCompleted('123456')),
    verify: (bloc) => expect(bloc.state.outcome, OtpOutcomeKind.needsRegistration),
  );

  blocTest<OtpBloc, OtpState>(
    'a wrong code shows tries left and bumps rejectedCodes so the boxes shake and clear',
    setUp: () => when(() => verifyOtp(any())).thenAnswer((_) async => const Left(InvalidOtpFailure(2))),
    build: build,
    seed: () => const OtpState(phoneNumber: _phone),
    act: (bloc) => bloc.add(const OtpCodeCompleted('000000')),
    verify: (bloc) {
      expect(bloc.state.error, OtpErrorKind.wrongCode);
      expect(bloc.state.attemptsLeft, 2);
      expect(bloc.state.rejectedCodes, 1);
      expect(bloc.state.isInputEnabled, isTrue);
    },
  );

  blocTest<OtpBloc, OtpState>(
    'a locked code disables input',
    setUp: () => when(() => verifyOtp(any())).thenAnswer((_) async => const Left(OtpLockedFailure())),
    build: build,
    seed: () => const OtpState(phoneNumber: _phone),
    act: (bloc) => bloc.add(const OtpCodeCompleted('000000')),
    verify: (bloc) {
      expect(bloc.state.isLocked, isTrue);
      expect(bloc.state.isInputEnabled, isFalse);
    },
  );

  blocTest<OtpBloc, OtpState>(
    'ignores codes while locked',
    build: build,
    seed: () => const OtpState(phoneNumber: _phone, error: OtpErrorKind.locked),
    act: (bloc) => bloc.add(const OtpCodeCompleted('123456')),
    expect: () => <OtpState>[],
    verify: (_) => verifyNever(() => verifyOtp(any())),
  );

  blocTest<OtpBloc, OtpState>(
    'Resend is unavailable until the countdown reaches 0:00',
    build: build,
    act: (bloc) => bloc.add(const OtpStarted(_phone)),
    verify: (bloc) {
      expect(bloc.state.canResend, isFalse);
      expect(bloc.state.resendSecondsLeft, OtpState.resendDelaySeconds);
    },
  );

  blocTest<OtpBloc, OtpState>(
    'Resend at 0:00 sends a new code, unlocks entry and restarts the countdown',
    build: () => build(_InstantTicker()),
    act: (bloc) async {
      bloc.add(const OtpStarted(_phone));
      await Future<void>.delayed(Duration.zero);
      bloc.add(const OtpResendRequested());
    },
    verify: (bloc) {
      verify(() => sendOtp(_phone)).called(1);
      expect(bloc.state.isLocked, isFalse);
      expect(bloc.state.isResending, isFalse);
    },
  );
}
