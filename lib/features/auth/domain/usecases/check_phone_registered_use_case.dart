import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Whether a phone number already has an account (used by Log in).
@lazySingleton
class CheckPhoneRegisteredUseCase implements UseCase<bool, String> {
  const CheckPhoneRegisteredUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<bool>> call(String phoneNumber) => _repository.isPhoneRegistered(phoneNumber);
}
