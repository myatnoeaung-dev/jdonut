import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/submission_status.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/time/clock.dart';
import 'package:jdonut/features/auth/domain/entities/registration_draft.dart';
import 'package:jdonut/features/auth/domain/entities/user.dart';
import 'package:jdonut/features/auth/domain/usecases/register_user_use_case.dart';
import 'package:jdonut/features/auth/domain/validators/birth_date_validator.dart';
import 'package:jdonut/features/auth/domain/validators/name_validator.dart';
import 'package:jdonut/features/auth/presentation/bloc/profile/profile_bloc.dart';

class _MockRegisterUser extends Mock implements RegisterUserUseCase {}

class _FixedClock implements Clock {
  @override
  DateTime now() => DateTime(2026, 11, 9);
}

const _phone = '+959254135592';
final _birthDate = DateTime(1995, 5, 1);
final _draft = RegistrationDraft(phoneNumber: _phone, firstName: 'Hania', lastName: null, birthDate: _birthDate);
final _user = User(id: '1', phoneNumber: _phone, firstName: 'Hania', lastName: null, birthDate: _birthDate);

void main() {
  late _MockRegisterUser registerUser;

  setUpAll(() => registerFallbackValue(_draft));
  setUp(() => registerUser = _MockRegisterUser());

  ProfileBloc build() => ProfileBloc(registerUser, _FixedClock());

  group('name step', () {
    blocTest<ProfileBloc, ProfileState>(
      'an empty first name shows the required message instead of moving on',
      build: build,
      act: (bloc) => bloc.add(const ProfileNameSubmitted()),
      verify: (bloc) {
        expect(bloc.state.visibleFirstNameError, NameError.empty);
        expect(bloc.state.nameConfirmations, 0);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'digits in the last name are rejected even though it is optional',
      build: build,
      act: (bloc) => bloc
        ..add(const ProfileFirstNameChanged('Hania'))
        ..add(const ProfileLastNameChanged('K2'))
        ..add(const ProfileNameSubmitted()),
      verify: (bloc) => expect(bloc.state.visibleLastNameError, NameError.invalidCharacters),
    );

    blocTest<ProfileBloc, ProfileState>(
      'a valid Myanmar first name with no last name moves on',
      build: build,
      act: (bloc) => bloc
        ..add(const ProfileFirstNameChanged('ရဲမင်း'))
        ..add(const ProfileNameSubmitted()),
      verify: (bloc) => expect(bloc.state.nameConfirmations, 1),
    );
  });

  group('date of birth step', () {
    test('Continue is disabled until a date is picked', () {
      expect(build().state.canSubmit, isFalse);
    });

    blocTest<ProfileBloc, ProfileState>(
      'someone younger than 13 sees tooYoung and cannot continue',
      build: build,
      act: (bloc) => bloc.add(ProfileBirthDateChanged(DateTime(2020, 1, 1))),
      verify: (bloc) {
        expect(bloc.state.visibleBirthDateError, BirthDateError.tooYoung);
        expect(bloc.state.canSubmit, isFalse);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'submitting creates the account with trimmed names',
      setUp: () => when(() => registerUser(_draft)).thenAnswer((_) async => Right(_user)),
      build: build,
      act: (bloc) => bloc
        ..add(const ProfileFirstNameChanged('  Hania '))
        ..add(ProfileBirthDateChanged(_birthDate))
        ..add(const ProfileSubmitted(_phone)),
      verify: (bloc) {
        verify(() => registerUser(_draft)).called(1);
        expect(bloc.state.status, SubmissionStatus.success);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'a failed registration shows failure and allows another try',
      setUp: () => when(() => registerUser(any())).thenAnswer((_) async => const Left(ServerFailure('down', null))),
      build: build,
      act: (bloc) => bloc
        ..add(const ProfileFirstNameChanged('Hania'))
        ..add(ProfileBirthDateChanged(_birthDate))
        ..add(const ProfileSubmitted(_phone)),
      verify: (bloc) {
        expect(bloc.state.status, SubmissionStatus.failure);
        expect(bloc.state.canSubmit, isTrue);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'a double tap on Continue creates only one account',
      setUp: () =>
          when(() => registerUser(any()))
              .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 50), () => Right(_user))),
      build: build,
      act: (bloc) => bloc
        ..add(const ProfileFirstNameChanged('Hania'))
        ..add(ProfileBirthDateChanged(_birthDate))
        ..add(const ProfileSubmitted(_phone))
        ..add(const ProfileSubmitted(_phone)),
      verify: (_) => verify(() => registerUser(any())).called(1),
    );
  });
}
