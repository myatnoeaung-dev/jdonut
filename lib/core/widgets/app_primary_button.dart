import 'package:flutter/material.dart';

/// Full-width pill button with an upper-case label (LET'S GET STARTED, CONTINUE…).
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({super.key, required this.label, required this.onPressed});

  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return FilledButton(
      onPressed: onPressed,
      child: Text(label.toUpperCase(), locale: locale, textAlign: TextAlign.center),
    );
  }
}
