import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/auth/domain/validators/name_validator.dart';

void main() {
  group('NameValidator', () {
    test('accepts letters and spaces', () {
      expect(NameValidator.validate('Ye Min', isRequired: true), isNull);
    });

    test('accepts Myanmar script', () {
      expect(NameValidator.validate('ရဲမင်း', isRequired: true), isNull);
    });

    test('trims surrounding spaces before checking', () {
      expect(NameValidator.validate('  Hania  ', isRequired: true), isNull);
    });

    test('returns empty when a required name is blank', () {
      expect(NameValidator.validate('   ', isRequired: true), NameError.empty);
    });

    test('allows an optional name to be blank', () {
      expect(NameValidator.validate('', isRequired: false), isNull);
    });

    test('allows exactly 50 characters and rejects 51', () {
      expect(NameValidator.validate('a' * NameValidator.maxLength, isRequired: true), isNull);
      expect(NameValidator.validate('a' * (NameValidator.maxLength + 1), isRequired: true), NameError.tooLong);
    });

    test('rejects digits, including Myanmar digits', () {
      expect(NameValidator.validate('Hania2', isRequired: true), NameError.invalidCharacters);
      expect(NameValidator.validate('ရဲ၁', isRequired: true), NameError.invalidCharacters);
    });

    test('rejects punctuation and symbols', () {
      expect(NameValidator.validate('Ye-Min!', isRequired: false), NameError.invalidCharacters);
    });
  });
}
