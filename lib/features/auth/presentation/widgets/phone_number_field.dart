import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/validators/phone_validator.dart';

/// Myanmar phone number field with a fixed +95 prefix. Digits, spaces and
/// dashes may be typed; the validator normalises them.
class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.onFocusLost,
    this.errorText,
  });

  static const String countryCode = PhoneValidator.countryCode;

  /// Room for 11 digits plus a few separators.
  static const int _maxInputLength = 15;
  static final RegExp _allowedCharacters = RegExp(r'[0-9 \-]');

  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFocusLost;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      label: l10n.phoneFieldLabel,
      textField: true,
      child: AppTextField(
        initialValue: initialValue,
        hintText: l10n.phoneHint,
        errorText: errorText,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.telephoneNumberNational],
        autofocus: true,
        inputFormatters: [
          FilteringTextInputFormatter.allow(_allowedCharacters),
          LengthLimitingTextInputFormatter(_maxInputLength),
        ],
        onChanged: onChanged,
        onFocusLost: onFocusLost,
        prefix: const _CountryCodePrefix(),
      ),
    );
  }
}

class _CountryCodePrefix extends StatelessWidget {
  const _CountryCodePrefix();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(color: context.palette.mutedText);
    // prefixIcon gets a min 48px-tall box; center the text in it so it lines up with the input.
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.md),
      child: Center(widthFactor: 1, child: Text(PhoneNumberField.countryCode, style: style)),
    );
  }
}
