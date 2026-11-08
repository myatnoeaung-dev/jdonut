part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// App launch: restore the session saved from last time.
final class AuthStarted extends AuthEvent {
  const AuthStarted();
}

/// Log out row in Settings.
final class AuthLogOutRequested extends AuthEvent {
  const AuthLogOutRequested();
}

/// The repository signed someone in (or out).
final class _AuthSessionChanged extends AuthEvent {
  const _AuthSessionChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}
