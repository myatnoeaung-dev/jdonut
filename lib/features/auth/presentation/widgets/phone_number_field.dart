import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Myanmar phone number field with a fixed +95 prefix.
class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key, required this.controller, this.onSubmitted});

  static const String countryCode = '+95';
  static const int _maxDigits = 11;

  final TextEditingController controller;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      label: l10n.phoneFieldLabel,
      textField: true,
      child: AppTextField(
        controller: controller,
        hintText: l10n.phoneHint,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.telephoneNumberNational],
        autofocus: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(_maxDigits)],
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
