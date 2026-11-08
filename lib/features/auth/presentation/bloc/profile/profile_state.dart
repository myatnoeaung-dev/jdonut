part of 'profile_bloc.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    required DateTime today,
    @Default('') String firstName,
    @Default('') String lastName,

    /// False until Continue is tapped on the name step.
    @Default(false) bool areNameErrorsVisible,

    /// Goes up each time valid names are confirmed; the page then opens the next step.
    @Default(0) int nameConfirmations,
    DateTime? birthDate,
    @Default(SubmissionStatus.idle) SubmissionStatus status,
  }) = _ProfileState;

  const ProfileState._();

  NameError? get firstNameError => NameValidator.validate(firstName, isRequired: true);

  NameError? get lastNameError => NameValidator.validate(lastName, isRequired: false);

  bool get isNameValid => firstNameError == null && lastNameError == null;

  NameError? get visibleFirstNameError => areNameErrorsVisible ? firstNameError : null;

  NameError? get visibleLastNameError => areNameErrorsVisible ? lastNameError : null;

  BirthDateError? get birthDateError => BirthDateValidator.validate(birthDate, today: today);

  /// No message before a date is picked; Continue just stays disabled.
  BirthDateError? get visibleBirthDateError => birthDate == null ? null : birthDateError;

  /// Also false once the account exists, so a late second tap can't register twice.
  bool get canSubmit => birthDateError == null && !status.isSubmitting && status != SubmissionStatus.success;
}
