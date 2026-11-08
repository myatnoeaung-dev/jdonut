import '../../../../core/error/failure.dart';

/// Logging in with a number that has no account.
class NotRegisteredFailure extends Failure {
  const NotRegisteredFailure() : super('Not registered', 'No account uses this phone number');
}

/// Creating an account for a number that already has one.
class AlreadyRegisteredFailure extends Failure {
  const AlreadyRegisteredFailure() : super('Already registered', 'This phone number already has an account');
}

/// Wrong OTP; [attemptsLeft] more tries before entry locks.
class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure(this.attemptsLeft) : super('Invalid code', 'The verification code is wrong');

  final int attemptsLeft;

  @override
  List<Object?> get props => [...super.props, attemptsLeft];
}

/// Too many wrong codes; entry stays locked until a new code is sent.
class OtpLockedFailure extends Failure {
  const OtpLockedFailure() : super('Code locked', 'Too many wrong codes');
}
