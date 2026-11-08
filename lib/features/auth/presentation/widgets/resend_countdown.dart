import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/highlighted_text.dart';

/// "Didn't receive the code? resend in 4:58 min", counting down from 5:00.
/// When it reaches zero it becomes a "Resend code" link.
class ResendCountdown extends StatefulWidget {
  const ResendCountdown({super.key, required this.onResend});

  static const Duration resendDelay = Duration(minutes: 5);

  final VoidCallback onResend;

  @override
  State<ResendCountdown> createState() => _ResendCountdownState();
}

class _ResendCountdownState extends State<ResendCountdown> {
  static const Duration _tick = Duration(seconds: 1);

  Timer? _timer;
  Duration _remaining = ResendCountdown.resendDelay;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    setState(() => _remaining = ResendCountdown.resendDelay);
    _timer = Timer.periodic(_tick, (_) => _onTick());
  }

  void _onTick() {
    final next = _remaining - _tick;
    setState(() => _remaining = next.isNegative ? Duration.zero : next);
    if (_remaining == Duration.zero) _timer?.cancel();
  }

  void _resend() {
    widget.onResend();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final highlight = TextStyle(color: context.palette.link);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.otpNotReceived, style: textTheme.bodyMedium),
        if (_remaining == Duration.zero)
          TextButton(
            onPressed: _resend,
            child: Text(l10n.otpResendNow, style: highlight),
          )
        else
          HighlightedText(
            message: l10n.otpResendIn(HighlightedText.token(0)),
            highlights: [HighlightSpan(_format(_remaining))],
            style: textTheme.bodyMedium,
            highlightStyle: highlight,
          ),
      ],
    );
  }

  static String _format(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(Duration.secondsPerMinute).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
