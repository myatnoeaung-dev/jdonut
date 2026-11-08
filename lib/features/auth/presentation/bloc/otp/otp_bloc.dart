import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/submission_status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/time/countdown_ticker.dart';
import '../../../domain/entities/otp_outcome.dart';
import '../../../domain/failures/auth_failures.dart';
import '../../../domain/usecases/send_otp_use_case.dart';
import '../../../domain/usecases/verify_otp_use_case.dart';
import '../../../domain/validators/otp_validator.dart';

part 'otp_bloc.freezed.dart';
part 'otp_event.dart';
part 'otp_state.dart';

/// Step 2: verifies the code, counts wrong attempts, locks after too many and
/// runs the resend countdown.
@injectable
class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc(this._verifyOtp, this._sendOtp, this._ticker) : super(const OtpState()) {
    on<OtpStarted>(_onStarted);
    on<OtpCodeCompleted>(_onCodeCompleted, transformer: droppable());
    on<OtpResendRequested>(_onResendRequested, transformer: droppable());
    on<_OtpCountdownTicked>((event, emit) => emit(state.copyWith(resendSecondsLeft: event.secondsLeft)));
  }

  final VerifyOtpUseCase _verifyOtp;
  final SendOtpUseCase _sendOtp;
  final CountdownTicker _ticker;
  StreamSubscription<int>? _countdown;

  void _onStarted(OtpStarted event, Emitter<OtpState> emit) {
    emit(OtpState(phoneNumber: event.phoneNumber));
    _restartCountdown();
  }

  Future<void> _onCodeCompleted(OtpCodeCompleted event, Emitter<OtpState> emit) async {
    if (!OtpValidator.isComplete(event.code) || !state.isInputEnabled) return;
    emit(state.copyWith(status: SubmissionStatus.submitting, error: null));
    final result = await _verifyOtp(VerifyOtpParams(phoneNumber: state.phoneNumber, code: event.code));
    emit(result.fold(_stateForFailure, _stateForOutcome));
  }

  Future<void> _onResendRequested(OtpResendRequested event, Emitter<OtpState> emit) async {
    if (!state.canResend) return;
    emit(state.copyWith(isResending: true));
    final sent = await _sendOtp(state.phoneNumber);
    sent.fold(
      (_) => emit(state.copyWith(isResending: false, error: OtpErrorKind.unknown)),
      (_) => emit(state.copyWith(isResending: false, error: null, status: SubmissionStatus.idle)),
    );
    if (sent.isRight()) _restartCountdown();
  }

  OtpState _stateForOutcome(OtpOutcome outcome) => state.copyWith(
    status: SubmissionStatus.success,
    outcome: outcome is OtpSignedIn ? OtpOutcomeKind.signedIn : OtpOutcomeKind.needsRegistration,
  );

  /// A wrong or locked code shakes and clears the boxes ([OtpState.rejectedCodes]).
  OtpState _stateForFailure(Failure failure) {
    final rejected = state.copyWith(status: SubmissionStatus.failure, rejectedCodes: state.rejectedCodes + 1);
    return switch (failure) {
      InvalidOtpFailure(:final attemptsLeft) => rejected.copyWith(
        error: OtpErrorKind.wrongCode,
        attemptsLeft: attemptsLeft,
      ),
      OtpLockedFailure() => rejected.copyWith(error: OtpErrorKind.locked, attemptsLeft: 0),
      _ => state.copyWith(status: SubmissionStatus.failure, error: OtpErrorKind.unknown),
    };
  }

  void _restartCountdown() {
    _countdown?.cancel();
    add(const _OtpCountdownTicked(OtpState.resendDelaySeconds));
    _countdown = _ticker
        .countdown(OtpState.resendDelaySeconds)
        .listen((secondsLeft) => add(_OtpCountdownTicked(secondsLeft)));
  }

  @override
  Future<void> close() async {
    await _countdown?.cancel();
    return super.close();
  }
}
