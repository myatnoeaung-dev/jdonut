part of 'otp_bloc.dart';

enum OtpErrorKind { wrongCode, locked, unknown }

/// Where a correct code leads: Home for members, the profile steps for new numbers.
enum OtpOutcomeKind { signedIn, needsRegistration }

@freezed
abstract class OtpState with _$OtpState {
  const factory OtpState({
    @Default('') String phoneNumber,
    @Default(SubmissionStatus.idle) SubmissionStatus status,
    OtpErrorKind? error,
    @Default(0) int attemptsLeft,

    /// Goes up with every rejected code; the field shakes and clears when it changes.
    @Default(0) int rejectedCodes,
    @Default(OtpState.resendDelaySeconds) int resendSecondsLeft,
    @Default(false) bool isResending,
    OtpOutcomeKind? outcome,
  }) = _OtpState;

  const OtpState._();

  /// Resend unlocks after 5:00.
  static const int resendDelaySeconds = 300;

  bool get isLocked => error == OtpErrorKind.locked;

  bool get isInputEnabled => !isLocked && !status.isSubmitting && status != SubmissionStatus.success;

  bool get canResend => resendSecondsLeft == 0 && !isResending;

  Duration get resendIn => Duration(seconds: resendSecondsLeft);
}
