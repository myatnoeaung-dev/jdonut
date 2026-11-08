import 'package:flutter/widgets.dart';

import 'package:injectable/injectable.dart';

import 'app_language.dart';

/// The language the user picked in Settings. Null follows the phone's language.
///
/// In memory only for now; persisting the choice comes with the settings logic.
@lazySingleton
class LocaleController extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLanguage(AppLanguage language) {
    if (_locale == language.locale) return;
    _locale = language.locale;
    notifyListeners();
  }
}
