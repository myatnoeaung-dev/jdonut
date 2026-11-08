import 'package:flutter/widgets.dart';

/// Languages the app ships. Names are shown in their own language (endonyms),
/// so they stay readable whichever language is active.
enum AppLanguage {
  english(Locale('en'), 'English'),
  burmese(Locale('my'), 'မြန်မာ');

  const AppLanguage(this.locale, this.nativeName);

  final Locale locale;
  final String nativeName;

  /// The language matching [locale], falling back to English.
  static AppLanguage fromLocale(Locale locale) => AppLanguage.values.firstWhere(
    (language) => language.locale.languageCode == locale.languageCode,
    orElse: () => AppLanguage.english,
  );
}
