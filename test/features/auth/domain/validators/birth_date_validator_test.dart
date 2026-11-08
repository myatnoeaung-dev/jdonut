import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/auth/domain/validators/birth_date_validator.dart';

void main() {
  final today = DateTime(2026, 11, 9);

  group('BirthDateValidator.validate', () {
    test('returns missing when no date is picked', () {
      expect(BirthDateValidator.validate(null, today: today), BirthDateError.missing);
    });

    test('accepts someone who turns 13 today', () {
      expect(BirthDateValidator.validate(DateTime(2013, 11, 9), today: today), isNull);
    });

    test('returns tooYoung one day before the 13th birthday', () {
      expect(BirthDateValidator.validate(DateTime(2013, 11, 10), today: today), BirthDateError.tooYoung);
    });

    test('returns inFuture for a date after today', () {
      expect(BirthDateValidator.validate(DateTime(2026, 11, 10), today: today), BirthDateError.inFuture);
    });

    test('ignores the time of day', () {
      expect(BirthDateValidator.validate(DateTime(2013, 11, 9, 23, 59), today: today), isNull);
    });
  });

  group('BirthDateValidator.validateParts', () {
    test('returns invalidDate for 31 April', () {
      expect(BirthDateValidator.validateParts(year: 1990, month: 4, day: 31, today: today), BirthDateError.invalidDate);
    });

    test('accepts 29 February in a leap year and rejects it otherwise', () {
      expect(BirthDateValidator.validateParts(year: 2004, month: 2, day: 29, today: today), isNull);
      expect(BirthDateValidator.validateParts(year: 2003, month: 2, day: 29, today: today), BirthDateError.invalidDate);
    });

    test('applies the age rule to a real date', () {
      expect(BirthDateValidator.validateParts(year: 2020, month: 1, day: 1, today: today), BirthDateError.tooYoung);
    });
  });
}
