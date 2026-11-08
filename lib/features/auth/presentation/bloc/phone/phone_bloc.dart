import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/submission_status.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../domain/usecases/check_phone_registered_use_case.dart';
import '../../../domain/usecases/send_otp_use_case.dart';
import '../../../domain/validators/phone_validator.dart';

part 'phone_bloc.freezed.dart';
part 'phone_event.dart';
part 'phone_state.dart';

/// Step 1: validates the number, checks it's registered when logging in, and
/// sends the code. Lives for the whole sign-in flow, so Back keeps the number.
@injectable
class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(this._checkPhoneRegistered, this._sendOtp) : super(const PhoneState()) {
    on<PhoneFlowSelected>((event, emit) => emit(state.copyWith(flow: event.flow)));
    on<PhoneChanged>(_onChanged);
    on<PhoneFocusLost>((_, emit) => emit(state.copyWith(isErrorVisible: state.input.isNotEmpty)));
    on<PhoneRegisterInsteadTapped>(_onRegisterInsteadTapped);
    on<PhoneSubmitted>(_onSubmitted, transformer: droppable());
  }

  final CheckPhoneRegisteredUseCase _checkPhoneRegistered;
  final SendOtpUseCase _sendOtp;

  void _onChanged(PhoneChanged event, Emitter<PhoneState> emit) {
    emit(state.copyWith(input: event.input, status: SubmissionStatus.idle, submitError: null));
  }

  /// Keeps the typed number and switches to sign-up.
  void _onRegisterInsteadTapped(PhoneRegisterInsteadTapped event, Emitter<PhoneState> emit) {
    emit(state.copyWith(flow: AuthFlow.register, status: SubmissionStatus.idle, submitError: null));
  }

  Future<void> _onSubmitted(PhoneSubmitted event, Emitter<PhoneState> emit) async {
    final phoneNumber = state.phoneNumber;
    if (phoneNumber == null) {
      emit(state.copyWith(isErrorVisible: true));
      return;
    }
    emit(state.copyWith(status: SubmissionStatus.submitting, submitError: null));
    final error = await _submit(phoneNumber);
    emit(
      state.copyWith(status: error == null ? SubmissionStatus.success : SubmissionStatus.failure, submitError: error),
    );
  }

  /// Log in needs an existing account; then a code is sent either way.
  Future<PhoneSubmitError?> _submit(String phoneNumber) async {
    if (state.flow == AuthFlow.login) {
      final registered = await _checkPhoneRegistered(phoneNumber);
      final loginError = registered.fold(
        (_) => PhoneSubmitError.unknown,
        (isRegistered) => isRegistered ? null : PhoneSubmitError.notRegistered,
      );
      if (loginError != null) return loginError;
    }
    final sent = await _sendOtp(phoneNumber);
    return sent.fold((_) => PhoneSubmitError.unknown, (_) => null);
  }
}
