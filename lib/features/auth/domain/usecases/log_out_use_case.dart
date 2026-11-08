import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Ends the session; the next launch opens Onboarding.
@lazySingleton
class LogOutUseCase implements UseCase<Unit, NoParams> {
  const LogOutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<Unit>> call(NoParams params) => _repository.logOut();
}
