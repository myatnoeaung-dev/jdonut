import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/usecase/usecase.dart';
import 'package:jdonut/features/auth/domain/entities/user.dart';
import 'package:jdonut/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:jdonut/features/auth/domain/usecases/watch_session_use_case.dart';
import 'package:jdonut/features/auth/presentation/bloc/auth/auth_bloc.dart';

class _MockRestoreSession extends Mock implements RestoreSessionUseCase {}

class _MockLogOut extends Mock implements LogOutUseCase {}

class _MockWatchSession extends Mock implements WatchSessionUseCase {}

final _user = User(
  id: '1',
  phoneNumber: '+959254135592',
  firstName: 'Hania',
  lastName: null,
  birthDate: DateTime(1995),
);

void main() {
  late _MockRestoreSession restoreSession;
  late _MockLogOut logOut;
  late _MockWatchSession watchSession;
  late StreamController<User?> sessionChanges;

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    restoreSession = _MockRestoreSession();
    logOut = _MockLogOut();
    watchSession = _MockWatchSession();
    sessionChanges = StreamController<User?>.broadcast();
    when(() => watchSession()).thenAnswer((_) => sessionChanges.stream);
  });

  tearDown(() => sessionChanges.close());

  AuthBloc build() => AuthBloc(restoreSession, logOut, watchSession);

  blocTest<AuthBloc, AuthState>(
    'a saved session restores as Authenticated',
    setUp: () => when(() => restoreSession(any())).thenAnswer((_) async => Right(_user)),
    build: build,
    act: (bloc) => bloc.add(const AuthStarted()),
    expect: () => [Authenticated(_user)],
  );

  blocTest<AuthBloc, AuthState>(
    'no saved session restores as Unauthenticated',
    setUp: () => when(() => restoreSession(any())).thenAnswer((_) async => const Right(null)),
    build: build,
    act: (bloc) => bloc.add(const AuthStarted()),
    expect: () => [const Unauthenticated()],
  );

  blocTest<AuthBloc, AuthState>(
    'an unreadable session is treated as signed out',
    setUp: () => when(() => restoreSession(any())).thenAnswer((_) async => const Left(CacheFailure('broken', null))),
    build: build,
    act: (bloc) => bloc.add(const AuthStarted()),
    expect: () => [const Unauthenticated()],
  );

  blocTest<AuthBloc, AuthState>(
    'follows sign-ins reported by the repository',
    build: build,
    act: (_) => sessionChanges.add(_user),
    expect: () => [Authenticated(_user)],
  );

  blocTest<AuthBloc, AuthState>(
    'log out ends the session',
    setUp: () => when(() => logOut(any())).thenAnswer((_) async => const Right(unit)),
    build: build,
    seed: () => Authenticated(_user),
    act: (bloc) => bloc.add(const AuthLogOutRequested()),
    expect: () => [const Unauthenticated()],
    verify: (_) => verify(() => logOut(any())).called(1),
  );
}
