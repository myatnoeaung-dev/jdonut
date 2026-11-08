part of 'phone_bloc.dart';

/// Why Continue on the phone step failed.
enum PhoneSubmitError { notRegistered, unknown }

@freezed
abstract class PhoneState with _$PhoneState {
  const factory PhoneState({
    @Default(AuthFlow.register) AuthFlow flow,
    @Default('') String input,

    /// False until the field loses focus or Continue is tapped.
    @Default(false) bool isErrorVisible,
    @Default(SubmissionStatus.idle) SubmissionStatus status,
    PhoneSubmitError? submitError,
  }) = _PhoneState;

  const PhoneState._();

  /// International form when [input] is valid, otherwise null.
  String? get phoneNumber => PhoneValidator.validate(input).toNullable();

  /// Validation message to show under the field, if any.
  PhoneError? get visibleError => isErrorVisible ? PhoneValidator.validate(input).getLeft().toNullable() : null;

  bool get canSubmit => phoneNumber != null && !status.isSubmitting;
}
