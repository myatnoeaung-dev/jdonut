import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// Ring at the top right of each registration step. Fills a quarter per step
/// and turns into a check on the last one.
class RegistrationProgressRing extends StatelessWidget {
  const RegistrationProgressRing({super.key, required this.step, required this.totalSteps});

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      label: context.l10n.registrationStep(step, totalSteps),
      child: SizedBox.square(
        dimension: AppSizes.progressRing,
        child: step >= totalSteps ? _CompletedMark(color: palette.progress) : _ring(palette),
      ),
    );
  }

  Widget _ring(AppPalette palette) => CustomPaint(
        painter: _RingPainter(
          progress: step / totalSteps,
          color: palette.progress,
          trackColor: palette.progressTrack,
        ),
      );
}

class _CompletedMark extends StatelessWidget {
  const _CompletedMark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(
        Icons.check_rounded,
        size: AppSizes.progressCheckIcon,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress, required this.color, required this.trackColor});

  final double progress;
  final Color color;
  final Color trackColor;

  static const double _startAngle = -math.pi / 2;
  static const double _fullTurn = 2 * math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(AppSizes.progressStroke / 2);
    canvas.drawArc(arcRect, 0, _fullTurn, false, _stroke(trackColor));
    canvas.drawArc(arcRect, _startAngle, _fullTurn * progress, false, _stroke(color));
  }

  Paint _stroke(Color strokeColor) => Paint()
    ..color = strokeColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = AppSizes.progressStroke;

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color || oldDelegate.trackColor != trackColor;
}
