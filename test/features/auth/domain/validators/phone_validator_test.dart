import 'package:flutter_test/flutter_test.dart';

import 'package:fpdart/fpdart.dart';

import 'package:jdonut/features/auth/domain/validators/phone_validator.dart';

void main() {
  group('PhoneValidator', () {
    test('turns a local number with a leading 0 into the +95 form', () {
      expect(PhoneValidator.validate('09254135592'), const Right<PhoneError, String>('+959254135592'));
    });

    test('accepts a number without the leading 0', () {
      expect(PhoneValidator.validate('9254135592'), const Right<PhoneError, String>('+959254135592'));
    });

    test('strips spaces and dashes', () {
      expect(PhoneValidator.validate('09 254-135 592'), const Right<PhoneError, String>('+959254135592'));
    });

    test('accepts a pasted number that already has +95', () {
      expect(PhoneValidator.validate('+959254135592'), const Right<PhoneError, String>('+959254135592'));
    });

    test('accepts the shortest (9 + 7 digits) and longest (9 + 9 digits) numbers', () {
      expect(PhoneValidator.validate('91234567').isRight(), isTrue);
      expect(PhoneValidator.validate('9123456789').isRight(), isTrue);
    });

    test('returns empty for blank input', () {
      expect(PhoneValidator.validate('  '), const Left<PhoneError, String>(PhoneError.empty));
    });

    test('returns invalidFormat when too short, too long, or not starting with 9', () {
      expect(PhoneValidator.validate('9123456'), const Left<PhoneError, String>(PhoneError.invalidFormat));
      expect(PhoneValidator.validate('91234567890'), const Left<PhoneError, String>(PhoneError.invalidFormat));
      expect(PhoneValidator.validate('0812345678'), const Left<PhoneError, String>(PhoneError.invalidFormat));
    });

    test('strips only one leading 0', () {
      expect(PhoneValidator.validate('009254135592'), const Left<PhoneError, String>(PhoneError.invalidFormat));
    });
  });
}
