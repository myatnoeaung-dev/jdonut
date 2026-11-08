import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/highlighted_text.dart';

/// "Didn't receive the code? resend in 4:58 min". At 0:00 it becomes a
/// "Resend code" link. The time comes from the OTP bloc.
class ResendCountdown extends StatelessWidget {
  const ResendCountdown({
    super.key,
    required this.remaining,
    required this.canResend,
    required this.isResending,
    required this.onResend,
  });

  final Duration remaining;
  final bool canResend;
  final bool isResending;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final highlight = TextStyle(color: context.palette.link);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.otpNotReceived, style: textTheme.bodyMedium),
        if (isResending)
          const _ResendingSpinner()
        else if (canResend)
          TextButton(
            onPressed: onResend,
            child: Text(l10n.otpResendNow, style: highlight),
          )
        else
          HighlightedText(
            message: l10n.otpResendIn(HighlightedText.token(0)),
            highlights: [HighlightSpan(_format(remaining))],
            style: textTheme.bodyMedium,
            highlightStyle: highlight,
          ),
      ],
    );
  }

  /// m:ss, e.g. 4:58.
  static String _format(Duration duration) {
    final seconds = duration.inSeconds.remainder(Duration.secondsPerMinute).toString().padLeft(2, '0');
    return '${duration.inMinutes}:$seconds';
  }
}

class _ResendingSpinner extends StatelessWidget {
  const _ResendingSpinner();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: SizedBox.square(dimension: AppSizes.inlineSpinner, child: CircularProgressIndicator()),
    );
  }
}
