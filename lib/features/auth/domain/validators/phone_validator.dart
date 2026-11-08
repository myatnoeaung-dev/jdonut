import 'package:fpdart/fpdart.dart';

enum PhoneError { empty, invalidFormat }

/// Myanmar mobile numbers. Accepts what people type — spaces, dashes and one
/// leading 0 — and returns the international form:
/// `09254135592` → `+959254135592`.
abstract final class PhoneValidator {
  static const String countryCode = '+95';

  static final RegExp _separators = RegExp(r'[\s-]');

  /// 9 followed by 7 to 9 digits.
  static final RegExp _nationalNumber = RegExp(r'^9\d{7,9}$');

  static Either<PhoneError, String> validate(String input) {
    var digits = input.replaceAll(_separators, '');
    if (digits.isEmpty) return const Left(PhoneError.empty);
    if (digits.startsWith(countryCode)) digits = digits.substring(countryCode.length);
    if (digits.startsWith('0')) digits = digits.substring(1);
    return _nationalNumber.hasMatch(digits) ? Right('$countryCode$digits') : const Left(PhoneError.invalidFormat);
  }
}
