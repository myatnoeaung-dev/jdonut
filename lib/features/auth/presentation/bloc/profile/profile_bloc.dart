import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc/submission_status.dart';
import '../../../../../core/time/clock.dart';
import '../../../domain/entities/registration_draft.dart';
import '../../../domain/usecases/register_user_use_case.dart';
import '../../../domain/validators/birth_date_validator.dart';
import '../../../domain/validators/name_validator.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

/// Steps 3–4 for new numbers: name, date of birth, then account creation.
@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._registerUser, Clock clock) : super(ProfileState(today: clock.now())) {
    on<ProfileFirstNameChanged>((event, emit) => emit(state.copyWith(firstName: event.value)));
    on<ProfileLastNameChanged>((event, emit) => emit(state.copyWith(lastName: event.value)));
    on<ProfileNameSubmitted>(_onNameSubmitted);
    on<ProfileBirthDateChanged>(
      (event, emit) => emit(state.copyWith(birthDate: event.date, status: SubmissionStatus.idle)),
    );
    on<ProfileSubmitted>(_onSubmitted, transformer: droppable());
  }

  final RegisterUserUseCase _registerUser;

  /// Valid names move on to the date of birth; otherwise show the messages.
  void _onNameSubmitted(ProfileNameSubmitted event, Emitter<ProfileState> emit) {
    emit(
      state.isNameValid
          ? state.copyWith(nameConfirmations: state.nameConfirmations + 1)
          : state.copyWith(areNameErrorsVisible: true),
    );
  }

  Future<void> _onSubmitted(ProfileSubmitted event, Emitter<ProfileState> emit) async {
    final birthDate = state.birthDate;
    if (!state.canSubmit || birthDate == null) return;
    emit(state.copyWith(status: SubmissionStatus.submitting));
    final registered = await _registerUser(_draft(event.phoneNumber, birthDate));
    emit(state.copyWith(status: registered.isRight() ? SubmissionStatus.success : SubmissionStatus.failure));
  }

  RegistrationDraft _draft(String phoneNumber, DateTime birthDate) {
    final lastName = state.lastName.trim();
    return RegistrationDraft(
      phoneNumber: phoneNumber,
      firstName: state.firstName.trim(),
      lastName: lastName.isEmpty ? null : lastName,
      birthDate: birthDate,
    );
  }
}
