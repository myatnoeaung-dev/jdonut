import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/session/auth_session.dart';
import 'core/usecase/usecase.dart';
import 'features/product/domain/usecases/seed_products_use_case.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await configureDependencies();
  await _seedLocalDatabase();
  runApp(JDonutApp(session: getIt<AuthSession>()));
}

/// First run only: fills the local database from bundled JSON. A failure is
/// logged, not fatal — screens show their own error/empty states.
Future<void> _seedLocalDatabase() async {
  final result = await getIt<SeedProductsUseCase>()(const NoParams());
  result.match(
    (failure) => debugPrint('Seeding products failed: ${failure.title} — ${failure.message}'),
    (_) {},
  );
}
