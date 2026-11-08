import 'package:injectable/injectable.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Sign-in / sign-out events, so the app-wide auth state follows them.
@lazySingleton
class WatchSessionUseCase {
  const WatchSessionUseCase(this._repository);

  final AuthRepository _repository;

  Stream<User?> call() => _repository.sessionChanges;
}
