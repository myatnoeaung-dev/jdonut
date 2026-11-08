import '../../../l10n/app_localizations.dart';
import '../domain/validators/birth_date_validator.dart';
import '../domain/validators/name_validator.dart';
import '../domain/validators/phone_validator.dart';
import 'bloc/otp/otp_bloc.dart';

/// Turns the domain's typed validation errors into localized messages.
extension AuthErrorMessages on AppLocalizations {
  String phoneErrorMessage(PhoneError error) => switch (error) {
    PhoneError.empty => phoneErrorEmpty,
    PhoneError.invalidFormat => phoneErrorInvalid,
  };

  String nameErrorMessage(NameError error) => switch (error) {
    NameError.empty => nameErrorRequired,
    NameError.tooLong => nameErrorTooLong(NameValidator.maxLength),
    NameError.invalidCharacters => nameErrorInvalid,
  };

  /// Null for [BirthDateError.missing]: before a date is picked, Continue is
  /// simply disabled.
  String? birthDateErrorMessage(BirthDateError error) => switch (error) {
    BirthDateError.missing => null,
    BirthDateError.invalidDate => birthDateErrorInvalid,
    BirthDateError.inFuture => birthDateErrorFuture,
    BirthDateError.tooYoung => birthDateErrorTooYoung(BirthDateValidator.minimumAgeYears),
  };

  String otpErrorMessage(OtpErrorKind error, {required int attemptsLeft}) => switch (error) {
    OtpErrorKind.wrongCode => otpWrongCode(attemptsLeft),
    OtpErrorKind.locked => otpLocked,
    OtpErrorKind.unknown => errorGeneric,
  };
}
