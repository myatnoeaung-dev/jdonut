import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/auth/data/auth_config.dart';
import 'package:jdonut/features/auth/presentation/widgets/otp_code_field.dart';
import 'package:jdonut/features/auth/presentation/widgets/phone_number_field.dart';

/// User actions shared by the auth flow tests.
extension AuthFlowActions on WidgetTester {
  Future<void> tapLabel(String label) async {
    await ensureVisible(find.text(label));
    await tap(find.text(label));
    await pumpAndSettle();
  }

  Future<void> tapLinkText(String text) async {
    await tapOnText(find.textRange.ofSubstring(text));
    await pumpAndSettle();
  }

  Future<void> enterPhone(String input) async {
    await enterText(find.descendant(of: find.byType(PhoneNumberField), matching: find.byType(TextField)), input);
    await pumpAndSettle();
  }

  Future<void> enterOtp([String code = AuthConfig.fakeOtpCode]) async {
    await enterText(find.descendant(of: find.byType(OtpCodeField), matching: find.byType(TextField)), code);
    await pumpAndSettle();
  }

  /// Types into the text field whose hint is [hint] (e.g. "First Name").
  Future<void> enterTextInField({required String hint, required String text}) async {
    await enterText(find.ancestor(of: find.text(hint), matching: find.byType(TextField)), text);
    await pumpAndSettle();
  }

  /// Opens the date picker from the Month field and accepts its default date
  /// (20 years ago, so old enough).
  Future<void> pickDefaultBirthDate() async {
    await tap(find.text('Month'));
    await pumpAndSettle();
    await tap(find.text('OK'));
    await pumpAndSettle();
  }

  /// Whether the button labelled [label] can be tapped.
  bool isButtonEnabled(String label) =>
      widget<FilledButton>(find.ancestor(of: find.text(label), matching: find.byType(FilledButton))).onPressed != null;
}
