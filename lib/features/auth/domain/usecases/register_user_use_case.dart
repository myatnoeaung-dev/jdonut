import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/registration_draft.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Creates the account at the end of sign-up and signs the new member in.
@lazySingleton
class RegisterUserUseCase implements UseCase<User, RegistrationDraft> {
  const RegisterUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<User>> call(RegistrationDraft draft) => _repository.register(draft);
}
