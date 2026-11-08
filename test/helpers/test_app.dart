import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:go_router/go_router.dart';

import 'package:jdonut/app.dart';
import 'package:jdonut/core/database/app_database.dart';
import 'package:jdonut/core/di/injection_container.config.dart';
import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/l10n/locale_controller.dart';
import 'package:jdonut/core/storage/session_storage.dart';
import 'package:jdonut/features/auth/data/auth_config.dart';
import 'package:jdonut/features/auth/domain/entities/registration_draft.dart';
import 'package:jdonut/features/auth/domain/repositories/auth_repository.dart';
import 'package:jdonut/features/auth/presentation/bloc/auth/auth_bloc.dart';

import 'in_memory_session_storage.dart';

/// The member most tests register: typed as 09254135592.
const String testPhoneInput = '09254135592';
const String testPhoneNumber = '+959254135592';

final RegistrationDraft testMember = RegistrationDraft(
  phoneNumber: testPhoneNumber,
  firstName: 'Hania',
  lastName: null,
  birthDate: DateTime(1995, 5, 1),
);

/// Real dependency graph, except: in-memory database, in-memory session and
/// no fake network delay (unless [fakeLatency] is given).
Future<void> setUpTestDependencies({Duration fakeLatency = Duration.zero}) async {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  await getIt.reset();
  getIt.allowReassignment = true;
  init(getIt);
  getIt
    ..registerSingleton<AppDatabase>(AppDatabase(NativeDatabase.memory()))
    ..registerSingleton<SessionStorage>(InMemorySessionStorage())
    ..registerSingleton<Duration>(fakeLatency, instanceName: AuthConfig.fakeLatencyName);
}

/// Pumps the whole app like `main.dart` does.
///
/// [isRegistered] creates [testMember]; [isSignedIn] also keeps them signed in,
/// so the app restores the session and opens on Home.
///
/// Everything runs in the test's own (fake-time) zone: the in-memory database
/// and the zero-latency fake backend only need microtasks, and blocs created
/// here keep working while the test pumps.
Future<void> pumpJDonutApp(
  WidgetTester tester, {
  bool isRegistered = false,
  bool isSignedIn = false,
  Duration fakeLatency = Duration.zero,
}) async {
  await setUpTestDependencies(fakeLatency: fakeLatency);
  if (isRegistered || isSignedIn) await getIt<AuthRepository>().register(testMember);
  if (isRegistered && !isSignedIn) await getIt<AuthRepository>().logOut();
  final authBloc = getIt<AuthBloc>()..add(const AuthStarted());
  await authBloc.stream.firstWhere((state) => state is! AuthUnknown);
  await tester.pumpWidget(JDonutApp(authBloc: authBloc, localeController: getIt<LocaleController>()));
  await tester.pumpAndSettle();
}

/// Unmounts the app so timers (e.g. the OTP countdown) don't outlive the test.
Future<void> unmountApp(WidgetTester tester) => tester.pumpWidget(const SizedBox());

GoRouter routerOf(WidgetTester tester) => GoRouter.of(tester.element(find.byType(Navigator).first));
