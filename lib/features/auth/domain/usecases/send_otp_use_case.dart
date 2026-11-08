import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Sends a verification code (first send and Resend).
@lazySingleton
class SendOtpUseCase implements UseCase<Unit, String> {
  const SendOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<Unit>> call(String phoneNumber) => _repository.sendOtp(phoneNumber);
}
