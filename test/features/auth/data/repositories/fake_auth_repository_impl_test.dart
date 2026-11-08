import 'package:flutter_test/flutter_test.dart';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/database/app_database.dart';
import 'package:jdonut/core/network/network_info.dart';
import 'package:jdonut/features/auth/data/auth_config.dart';
import 'package:jdonut/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:jdonut/features/auth/data/repositories/fake_auth_repository_impl.dart';
import 'package:jdonut/features/auth/domain/entities/registration_draft.dart';
import 'package:jdonut/features/auth/domain/failures/auth_failures.dart';

import '../../../../helpers/in_memory_session_storage.dart';

class _MockNetworkInfo extends Mock implements NetworkInfo {}

const _phone = '+959254135592';
final _draft = RegistrationDraft(
  phoneNumber: _phone,
  firstName: 'Hania',
  lastName: null,
  birthDate: DateTime(1995, 5, 1),
);

void main() {
  late AppDatabase database;
  late InMemorySessionStorage session;

  FakeAuthRepositoryImpl newRepository() => FakeAuthRepositoryImpl(
    AuthLocalDatasourceImpl(database),
    session,
    Duration.zero,
    networkInfo: _MockNetworkInfo(),
  );

  setUp(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    database = AppDatabase(NativeDatabase.memory());
    session = InMemorySessionStorage();
  });

  tearDown(() => database.close());

  group('registration and log in', () {
    test('a new number is not registered', () async {
      expect((await newRepository().isPhoneRegistered(_phone)).getRight().toNullable(), isFalse);
    });

    test('register stores the member, saves the session and announces it', () async {
      final repository = newRepository();
      final announced = expectLater(repository.sessionChanges, emits(isNotNull));

      final user = (await repository.register(_draft)).getRight().toNullable();

      expect(user?.firstName, 'Hania');
      expect(await session.readUserId(), user?.id);
      expect((await repository.isPhoneRegistered(_phone)).getRight().toNullable(), isTrue);
      await announced;
    });

    test('registering a taken number fails with AlreadyRegisteredFailure', () async {
      final repository = newRepository();
      await repository.register(_draft);

      expect((await repository.register(_draft)).getLeft().toNullable(), isA<AlreadyRegisteredFailure>());
    });

    test('logging in with an unknown number fails with NotRegisteredFailure', () async {
      expect((await newRepository().logIn(_phone)).getLeft().toNullable(), isA<NotRegisteredFailure>());
    });
  });

  group('session', () {
    test('a relaunch restores the saved member', () async {
      await newRepository().register(_draft);

      final restored = await newRepository().restoreSession();

      expect(restored.getRight().toNullable()?.phoneNumber, _phone);
    });

    test('after log out a relaunch finds nobody', () async {
      final repository = newRepository();
      await repository.register(_draft);
      await repository.logOut();

      expect((await newRepository().restoreSession()).getRight().toNullable(), isNull);
    });

    test('a saved id with no matching member is cleared', () async {
      await session.saveUserId('99');

      expect((await newRepository().restoreSession()).getRight().toNullable(), isNull);
      expect(await session.readUserId(), isNull);
    });
  });

  group('OTP', () {
    test('accepts the fake code', () async {
      final result = await newRepository().verifyOtp(phoneNumber: _phone, code: AuthConfig.fakeOtpCode);

      expect(result.isRight(), isTrue);
    });

    test('counts down attempts, then locks on the third wrong code', () async {
      final repository = newRepository();

      final first = await repository.verifyOtp(phoneNumber: _phone, code: '000000');
      final second = await repository.verifyOtp(phoneNumber: _phone, code: '000000');
      final third = await repository.verifyOtp(phoneNumber: _phone, code: '000000');

      expect(first.getLeft().toNullable(), const InvalidOtpFailure(2));
      expect(second.getLeft().toNullable(), const InvalidOtpFailure(1));
      expect(third.getLeft().toNullable(), isA<OtpLockedFailure>());
    });

    test('stays locked even for the right code until a new code is sent', () async {
      final repository = newRepository();
      for (var attempt = 0; attempt < AuthConfig.maxOtpAttempts; attempt++) {
        await repository.verifyOtp(phoneNumber: _phone, code: '000000');
      }

      final whileLocked = await repository.verifyOtp(phoneNumber: _phone, code: AuthConfig.fakeOtpCode);
      await repository.sendOtp(_phone);
      final afterResend = await repository.verifyOtp(phoneNumber: _phone, code: AuthConfig.fakeOtpCode);

      expect(whileLocked.getLeft().toNullable(), isA<OtpLockedFailure>());
      expect(afterResend.isRight(), isTrue);
    });
  });
}
