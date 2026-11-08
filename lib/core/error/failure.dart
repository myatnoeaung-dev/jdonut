import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? title;
  final String? message;
  const Failure(this.title, this.message, [List properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [title, message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.title, super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.title, super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.title, super.message);
}

class LoginAttemptExceedFailure extends Failure {
  const LoginAttemptExceedFailure(super.title, super.message);
}

class UserDeactivateFailure extends Failure {
  const UserDeactivateFailure(super.title, super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(String? title, String? message) : super(title ?? "Error occur for empty cache", message);
}

/// The requested record doesn't exist locally (e.g. an unknown `/product/:id`).
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.title, super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.title, super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.title, super.message);
}

/// The user dismissed a third-party sign-in sheet; not an error to surface.
class SignInCancelledFailure extends Failure {
  const SignInCancelledFailure() : super('Sign-in cancelled', null);
}
