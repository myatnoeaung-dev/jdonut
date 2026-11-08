import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'l10n_extension.dart';

extension PriceFormatting on BuildContext {
  /// "3,200 MMK" — grouped digits in the current locale.
  String formatMmk(int amount) {
    final locale = Localizations.localeOf(this).toLanguageTag();
    return l10n.priceMmk(NumberFormat.decimalPattern(locale).format(amount));
  }
}
