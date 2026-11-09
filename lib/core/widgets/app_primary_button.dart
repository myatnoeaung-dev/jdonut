import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_motion.dart';
import 'press_scale.dart';

/// Full-width pill button with an upper-case label (LET'S GET STARTED, CONTINUE…).
///
/// Shrinks a little while pressed. While [isLoading] it morphs into a circle
/// with a spinner, then grows back when loading ends.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({super.key, required this.label, required this.onPressed, this.isLoading = false});

  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;

  /// Shows a spinner and ignores taps, so a double tap sends only one request.
  final bool isLoading;

  static const Duration _morph = Duration(milliseconds: 350);
  static const double _labelPadding = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    final duration = context.reduceMotion ? Duration.zero : _morph;
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        return Center(
          child: AnimatedContainer(
            duration: duration,
            curve: AppCurves.emphasized,
            width: isLoading ? AppSizes.buttonHeight : fullWidth,
            child: AbsorbPointer(
              absorbing: isLoading,
              child: PressScale(
                enabled: onPressed != null && !isLoading,
                child: FilledButton(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                  child: _content(context, fullWidth, duration),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// The label keeps its full-width layout and is clipped as the button
  /// narrows, so it never re-wraps mid-morph; the spinner fades in on top.
  Widget _content(BuildContext context, double fullWidth, Duration duration) {
    final labelWidth = (fullWidth - _labelPadding * 2).clamp(0, double.infinity).toDouble();
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: duration,
          child: UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(width: labelWidth, child: _label(context)),
          ),
        ),
        if (isLoading) const _ButtonSpinner(),
      ],
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
