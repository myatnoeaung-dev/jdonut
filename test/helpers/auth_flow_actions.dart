import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/auth/data/auth_config.dart';
import 'package:jdonut/features/auth/presentation/widgets/otp_code_field.dart';
import 'package:jdonut/features/auth/presentation/widgets/phone_number_field.dart';

import 'pump_until.dart';

/// User actions shared by the auth flow tests.
extension AuthFlowActions on WidgetTester {
  Future<void> tapLabel(String label) async {
    await pumpUntilFound(find.text(label));
    // A disabled button ignores the tap; say so instead of failing on the next screen.
    final button = find.ancestor(of: find.text(label), matching: find.byType(FilledButton));
    if (button.evaluate().isNotEmpty && widget<FilledButton>(button.first).onPressed == null) {
      throw TestFailure('"$label" is disabled\n${describeScreen()}');
    }
    await ensureVisible(find.text(label));
    await tap(find.text(label));
    await pumpAndSettle();
  }

  Future<void> tapLinkText(String text) async {
    await tapOnText(find.textRange.ofSubstring(text));
    await pumpAndSettle();
  }

  Future<void> enterPhone(String input) async {
    final field = find.descendant(of: find.byType(PhoneNumberField), matching: find.byType(TextField));
    await pumpUntilFound(field);
    await typeInto(field, input);
    await pumpAndSettle();
  }

  Future<void> enterOtp([String code = AuthConfig.fakeOtpCode]) async {
    final field = find.descendant(of: find.byType(OtpCodeField), matching: find.byType(TextField));
    await pumpUntilFound(field);
    await typeInto(field, code);
    await pumpAndSettle();
  }

  /// Types into the text field whose hint is [hint] (e.g. "First Name").
  Future<void> enterTextInField({required String hint, required String text}) async {
    final field = find.ancestor(of: find.text(hint), matching: find.byType(TextField));
    await pumpUntilFound(field);
    await typeInto(field, text);
    await pumpAndSettle();
  }

  /// Opens the date picker from the Month field and accepts its default date
  /// (20 years ago, so old enough).
  Future<void> pickDefaultBirthDate() async {
    await pumpUntilFound(find.text('Month'));
    await tap(find.text('Month'));
    await pumpUntilFound(find.text('OK'));
    await tap(find.text('OK'));
    await pumpAndSettle();
  }

  /// Focuses [field] and puts [text] in it the way a keyboard does (through the
  /// field's formatters and `onChanged`).
  ///
  /// Unlike `enterText`, this doesn't need the test keyboard: in integration tests
  /// on a phone the field talks to the real keyboard, and in profile mode
  /// `enterText` then silently types nothing.
  Future<void> typeInto(Finder field, String text) async {
    await showKeyboard(field);
    final editable = state<EditableTextState>(find.descendant(of: field, matching: find.byType(EditableText)));
    editable.updateEditingValue(
      TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      ),
    );
    await pump();
  }

  /// Whether the button labelled [label] can be tapped.
  bool isButtonEnabled(String label) =>
      widget<FilledButton>(find.ancestor(of: find.text(label), matching: find.byType(FilledButton))).onPressed != null;
}
