import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/l10n/locale_controller.dart';
import 'core/usecase/usecase.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/product/domain/usecases/seed_products_use_case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureDependencies();
  await _seedLocalDatabase();
  final authBloc = await _restoreSession();
  runApp(JDonutApp(authBloc: authBloc, localeController: getIt<LocaleController>()));
}

/// First run only: fills the local database from bundled JSON. A failure is
/// logged, not fatal — screens show their own error/empty states.
Future<void> _seedLocalDatabase() async {
  final result = await getIt<SeedProductsUseCase>()(const NoParams());
  result.match((failure) => debugPrint('Seeding products failed: ${failure.title} — ${failure.message}'), (_) {});
}

/// Reads the saved session before the first frame, so a signed-in member
/// opens straight on Home and a signed-out one on Onboarding.
Future<AuthBloc> _restoreSession() async {
  final authBloc = getIt<AuthBloc>()..add(const AuthStarted());
  await authBloc.stream.firstWhere((state) => state is! AuthUnknown);
  return authBloc;
}
