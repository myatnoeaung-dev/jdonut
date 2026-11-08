import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/otp_outcome.dart';
import '../failures/auth_failures.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpParams extends Equatable {
  const VerifyOtpParams({required this.phoneNumber, required this.code});

  final String phoneNumber;
  final String code;

  @override
  List<Object?> get props => [phoneNumber, code];
}

/// Checks the code, then signs existing members in. New numbers come back as
/// [OtpNeedsRegistration] so the app can ask for name and date of birth.
@lazySingleton
class VerifyOtpUseCase implements UseCase<OtpOutcome, VerifyOtpParams> {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<OtpOutcome>> call(VerifyOtpParams params) async {
    final verified = await _repository.verifyOtp(phoneNumber: params.phoneNumber, code: params.code);
    return verified.fold<Future<Result<OtpOutcome>>>(
      (failure) async => Left(failure),
      (_) => _signInIfRegistered(params.phoneNumber),
    );
  }

  Future<Result<OtpOutcome>> _signInIfRegistered(String phoneNumber) async {
    final loggedIn = await _repository.logIn(phoneNumber);
    return loggedIn.fold(
      (failure) => failure is NotRegisteredFailure ? const Right(OtpNeedsRegistration()) : Left(failure),
      (user) => Right(OtpSignedIn(user)),
    );
  }
}
