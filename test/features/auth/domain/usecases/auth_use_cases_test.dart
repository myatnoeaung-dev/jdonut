import 'package:flutter_test/flutter_test.dart';

import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/usecase/usecase.dart';
import 'package:jdonut/features/auth/domain/entities/otp_outcome.dart';
import 'package:jdonut/features/auth/domain/entities/registration_draft.dart';
import 'package:jdonut/features/auth/domain/entities/user.dart';
import 'package:jdonut/features/auth/domain/failures/auth_failures.dart';
import 'package:jdonut/features/auth/domain/repositories/auth_repository.dart';
import 'package:jdonut/features/auth/domain/usecases/check_phone_registered_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/register_user_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/send_otp_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/watch_session_use_case.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

const _phone = '+959254135592';
final _user = User(id: '1', phoneNumber: _phone, firstName: 'Hania', lastName: null, birthDate: DateTime(1995, 5, 1));
final _draft = RegistrationDraft(
  phoneNumber: _phone,
  firstName: 'Hania',
  lastName: null,
  birthDate: DateTime(1995, 5, 1),
);
const _serverDown = ServerFailure('Server error', null);

void main() {
  late _MockAuthRepository repository;

  setUp(() => repository = _MockAuthRepository());

  group('VerifyOtpUseCase', () {
    const params = VerifyOtpParams(phoneNumber: _phone, code: '123456');

    test('signs a registered member in after a correct code', () async {
      when(() => repository.verifyOtp(phoneNumber: _phone, code: '123456')).thenAnswer((_) async => const Right(unit));
      when(() => repository.logIn(_phone)).thenAnswer((_) async => Right(_user));

      expect(await VerifyOtpUseCase(repository)(params), Right<Failure, OtpOutcome>(OtpSignedIn(_user)));
    });

    test('asks a new number to register after a correct code', () async {
      when(() => repository.verifyOtp(phoneNumber: _phone, code: '123456')).thenAnswer((_) async => const Right(unit));
      when(() => repository.logIn(_phone)).thenAnswer((_) async => const Left(NotRegisteredFailure()));

      expect(await VerifyOtpUseCase(repository)(params), const Right<Failure, OtpOutcome>(OtpNeedsRegistration()));
    });

    test('returns the code failure without trying to log in', () async {
      when(() => repository.verifyOtp(phoneNumber: _phone, code: '123456'))
          .thenAnswer((_) async => const Left(InvalidOtpFailure(2)));

      expect(await VerifyOtpUseCase(repository)(params), const Left<Failure, OtpOutcome>(InvalidOtpFailure(2)));
      verifyNever(() => repository.logIn(any()));
    });

    test('returns other log-in failures as failures', () async {
      when(() => repository.verifyOtp(phoneNumber: _phone, code: '123456')).thenAnswer((_) async => const Right(unit));
      when(() => repository.logIn(_phone)).thenAnswer((_) async => const Left(_serverDown));

      expect(await VerifyOtpUseCase(repository)(params), const Left<Failure, OtpOutcome>(_serverDown));
    });
  });

  test('CheckPhoneRegisteredUseCase passes the answer through', () async {
    when(() => repository.isPhoneRegistered(_phone)).thenAnswer((_) async => const Right(false));

    expect(await CheckPhoneRegisteredUseCase(repository)(_phone), const Right<Failure, bool>(false));
  });

  test('SendOtpUseCase returns a failure when the code cannot be sent', () async {
    when(() => repository.sendOtp(_phone)).thenAnswer((_) async => const Left(_serverDown));

    expect(await SendOtpUseCase(repository)(_phone), const Left<Failure, Unit>(_serverDown));
  });

  test('RegisterUserUseCase returns the new member', () async {
    when(() => repository.register(_draft)).thenAnswer((_) async => Right(_user));

    expect(await RegisterUserUseCase(repository)(_draft), Right<Failure, User>(_user));
  });

  test('RegisterUserUseCase returns AlreadyRegisteredFailure for a taken number', () async {
    when(() => repository.register(_draft)).thenAnswer((_) async => const Left(AlreadyRegisteredFailure()));

    expect(await RegisterUserUseCase(repository)(_draft), const Left<Failure, User>(AlreadyRegisteredFailure()));
  });

  test('RestoreSessionUseCase returns null when nobody is signed in', () async {
    when(() => repository.restoreSession()).thenAnswer((_) async => const Right(null));

    expect(await RestoreSessionUseCase(repository)(const NoParams()), const Right<Failure, User?>(null));
  });

  test('LogOutUseCase ends the session', () async {
    when(() => repository.logOut()).thenAnswer((_) async => const Right(unit));

    expect(await LogOutUseCase(repository)(const NoParams()), const Right<Failure, Unit>(unit));
  });

  test('WatchSessionUseCase forwards sign-in changes', () {
    when(() => repository.sessionChanges).thenAnswer((_) => Stream.value(_user));

    expect(WatchSessionUseCase(repository)(), emits(_user));
  });
}
