/// One-time codes are exactly six digits.
abstract final class OtpValidator {
  static const int length = 6;

  static final RegExp _sixDigits = RegExp('^\\d{$length}\$');

  static bool isComplete(String code) => _sixDigits.hasMatch(code);
}
