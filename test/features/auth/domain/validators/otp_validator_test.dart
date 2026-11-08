import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/auth/domain/validators/otp_validator.dart';

void main() {
  group('OtpValidator.isComplete', () {
    test('is true for exactly six digits', () => expect(OtpValidator.isComplete('123456'), isTrue));

    test('is false for fewer or more than six digits', () {
      expect(OtpValidator.isComplete('12345'), isFalse);
      expect(OtpValidator.isComplete('1234567'), isFalse);
    });

    test('is false when the code contains non-digits', () => expect(OtpValidator.isComplete('12a456'), isFalse));
  });
}
