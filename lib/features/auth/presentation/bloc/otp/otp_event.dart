part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

/// A code was just sent to [phoneNumber]: reset attempts and start the countdown.
final class OtpStarted extends OtpEvent {
  const OtpStarted(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

/// All six digits entered (typed, pasted or autofilled).
final class OtpCodeCompleted extends OtpEvent {
  const OtpCodeCompleted(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

final class OtpResendRequested extends OtpEvent {
  const OtpResendRequested();
}

final class _OtpCountdownTicked extends OtpEvent {
  const _OtpCountdownTicked(this.secondsLeft);

  final int secondsLeft;

  @override
  List<Object?> get props => [secondsLeft];
}
