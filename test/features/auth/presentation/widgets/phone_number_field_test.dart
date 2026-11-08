import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/theme/app_theme.dart';
import 'package:jdonut/features/auth/presentation/widgets/phone_number_field.dart';
import 'package:jdonut/l10n/app_localizations.dart';

void main() {
  testWidgets('+95 prefix lines up with the input text', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // Column keeps the field at its natural height, like on the phone screen.
        home: Scaffold(
          body: Column(children: [PhoneNumberField(controller: TextEditingController())]),
        ),
      ),
    );

    final prefix = tester.getRect(find.text(PhoneNumberField.countryCode));
    final input = tester.getRect(find.byType(EditableText));

    // Comparing tops (not centres) catches text drawn at the top of a taller box.
    expect(prefix.top, moreOrLessEquals(input.top, epsilon: 1));
    expect(prefix.height, moreOrLessEquals(input.height, epsilon: 1));
  });
}
