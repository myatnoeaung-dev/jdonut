import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';

/// Full-width pill button with an upper-case label (LET'S GET STARTED, CONTINUE…).
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({super.key, required this.label, required this.onPressed, this.isLoading = false});

  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;

  /// Shows a spinner and ignores taps, so a double tap sends only one request.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: FilledButton(onPressed: onPressed, child: isLoading ? const _ButtonSpinner() : _label(context)),
    );
  }

  Widget _label(BuildContext context) =>
      Text(label.toUpperCase(), locale: Localizations.localeOf(context), textAlign: TextAlign.center);
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  static const double _strokeWidth = 2.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSizes.buttonSpinner,
      child: CircularProgressIndicator(strokeWidth: _strokeWidth, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
