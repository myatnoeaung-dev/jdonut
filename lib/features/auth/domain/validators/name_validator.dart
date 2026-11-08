enum NameError { empty, tooLong, invalidCharacters }

/// First and last names: 1–50 characters after trimming, letters (any script,
/// Myanmar included) and spaces only — no digits.
abstract final class NameValidator {
  static const int maxLength = 50;

  /// Letters plus combining marks, which Myanmar vowel signs and tones use.
  static final RegExp _lettersAndSpaces = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);

  /// Returns null when [input] is valid. An optional name may be left empty.
  static NameError? validate(String input, {required bool isRequired}) {
    final name = input.trim();
    if (name.isEmpty) return isRequired ? NameError.empty : null;
    if (name.runes.length > maxLength) return NameError.tooLong;
    if (!_lettersAndSpaces.hasMatch(name)) return NameError.invalidCharacters;
    return null;
  }
}
