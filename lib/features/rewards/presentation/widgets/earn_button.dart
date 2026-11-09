import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/press_scale.dart';

/// Small cyan EARN pill. When [isReady] it pulses a few times after
/// [attentionDelay] to draw the eye and shrinks while pressed; otherwise it's
/// grey and inert.
class EarnButton extends StatefulWidget {
  const EarnButton({super.key, required this.isReady, this.onPressed, this.attentionDelay = Duration.zero});

  final bool isReady;

  /// Called after the press feedback; null does nothing beyond the feedback.
  final VoidCallback? onPressed;
  final Duration attentionDelay;

  @override
  State<EarnButton> createState() => _EarnButtonState();
}

class _EarnButtonState extends State<EarnButton> with SingleTickerProviderStateMixin {
  static const int _pulseCount = 3;
  static const double _pulseGrowth = 0.08;
  static const double _pressedScale = 0.92;
  static const double _glowAlpha = 0.5;

  late final AnimationController _attention = AnimationController(
    vsync: this,
    duration: widget.attentionDelay + AppDurations.attentionPulse * _pulseCount,
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started || !widget.isReady) return;
    _started = true;
    // Pulses are only a cue: with reduced motion, skip them entirely.
    if (!context.reduceMotion) _attention.forward();
  }

  @override
  void dispose() {
    _attention.dispose();
    super.dispose();
  }

  /// 0 → 1 → 0 once per pulse, after the delay.
  double get _pulse {
    final start = delayedInterval(widget.attentionDelay, _attention.duration!).begin;
    if (_attention.value <= start) return 0;
    final phase = (_attention.value - start) / (1 - start) * _pulseCount;
    return math.sin((phase % 1) * math.pi);
  }

  void _handlePressed() {
    HapticFeedback.lightImpact();
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final glow = Theme.of(context).colorScheme.primary.withValues(alpha: _glowAlpha);
    return PressScale(
      enabled: widget.isReady,
      pressedScale: _pressedScale,
      child: AnimatedBuilder(
        animation: _attention,
        builder: (context, child) => Transform.scale(
          scale: 1 + _pulseGrowth * _pulse,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              boxShadow: [
                BoxShadow(
                  color: glow.withValues(alpha: glow.a * _pulse),
                  blurRadius: AppSpacing.md,
                ),
              ],
            ),
            child: child,
          ),
        ),
        child: _button(context),
      ),
    );
  }

  Widget _button(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FilledButton(
      onPressed: widget.isReady ? _handlePressed : null,
      style: FilledButton.styleFrom(
        minimumSize: const Size(AppSizes.earnButtonWidth, AppSizes.earnButtonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        disabledBackgroundColor: context.palette.disabledFill,
        disabledForegroundColor: colors.surface,
      ),
      child: Text(context.l10n.earn.toUpperCase(), locale: Localizations.localeOf(context)),
    );
  }
}
