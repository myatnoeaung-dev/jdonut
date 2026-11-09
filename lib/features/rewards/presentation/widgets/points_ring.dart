import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';

/// Pink sprinkled donut ring that fills with progress to the next tier, with
/// the total points in the middle. Always square.
///
/// On entry the ring sweeps from 0 while the total counts up.
class PointsRing extends StatelessWidget {
  const PointsRing({super.key, required this.points, required this.progress});

  final int points;

  /// 0 to 1.
  final double progress;

  /// Ring thickness as a share of the diameter.
  static const double _ringThicknessFactor = 0.22;

  /// Width of the centre text, inside the hole of the ring.
  static const double _labelWidthFactor = 0.5;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final duration = context.reduceMotion ? Duration.zero : AppDurations.ringSweep;
    // Screen readers hear the final total, not the count-up.
    return Semantics(
      label: '${l10n.totalPoints} ${l10n.pointsValue(points)}',
      excludeSemantics: true,
      child: AspectRatio(
        aspectRatio: 1,
        // Starts from 0 on entry, then animates from the old values on updates.
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: progress),
          duration: duration,
          curve: AppCurves.emphasized,
          builder: (context, shownProgress, label) =>
              CustomPaint(painter: _painter(context.palette, shownProgress), child: label),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: points.toDouble()),
            duration: duration,
            curve: AppCurves.emphasized,
            builder: (context, shownPoints, _) => _CentreLabel(points: shownPoints.round()),
          ),
        ),
      ),
    );
  }

  _PointsRingPainter _painter(AppPalette palette, double shownProgress) => _PointsRingPainter(
    progress: shownProgress,
    thicknessFactor: _ringThicknessFactor,
    trackColor: palette.pageBackground,
    ringColor: palette.progress,
    sprinkleColors: palette.sprinkles,
  );
}

/// "Total points" and the number, inside the hole of the ring.
class _CentreLabel extends StatelessWidget {
  const _CentreLabel({required this.points});

  final int points;

  /// Same-width digits, so the label doesn't wobble while counting.
  static const List<FontFeature> _tabularDigits = [FontFeature.tabularFigures()];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final labelColor = context.palette.progress;
    return Center(
      child: FractionallySizedBox(
        widthFactor: PointsRing._labelWidthFactor,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.totalPoints, style: textTheme.bodySmall?.copyWith(color: labelColor)),
              Text(
                l10n.pointsValue(points),
                style: textTheme.headlineSmall?.copyWith(color: labelColor, fontFeatures: _tabularDigits),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PointsRingPainter extends CustomPainter {
  const _PointsRingPainter({
    required this.progress,
    required this.thicknessFactor,
    required this.trackColor,
    required this.ringColor,
    required this.sprinkleColors,
  });

  final double progress;
  final double thicknessFactor;
  final Color trackColor;
  final Color ringColor;
  final List<Color> sprinkleColors;

  static const double _startAngle = -math.pi / 2; // 12 o'clock
  static const double _fullTurn = 2 * math.pi;

  /// Roughly one sprinkle every 0.3 radians of filled ring.
  static const double _sprinkleSpacing = 0.3;

  /// Each sprinkle's distance from the ring's centre line and its tilt,
  /// repeated around the ring so the pattern looks scattered.
  static const List<double> _radialOffsets = [-0.24, 0.12, 0.28, -0.06, 0.2, -0.28, 0.04];
  static const List<double> _tilts = [0.9, -0.5, 1.6, 0.2, -1.2, 0.7, -0.1];
  static const double _sprinkleLengthFactor = 0.2;
  static const double _sprinkleWidthFactor = 0.07;

  @override
  void paint(Canvas canvas, Size size) {
    final thickness = size.shortestSide * thicknessFactor;
    final radius = (size.shortestSide - thickness) / 2;
    final center = size.center(Offset.zero);
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, ring..color = trackColor);
    final sweep = _fullTurn * progress;
    if (sweep <= 0) return;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), _startAngle, sweep, false, ring..color = ringColor);
    _paintSprinkles(canvas, center, radius, thickness, sweep);
  }

  void _paintSprinkles(Canvas canvas, Offset center, double radius, double thickness, double sweep) {
    final count = math.max(1, (sweep / _sprinkleSpacing).floor());
    final halfLength = thickness * _sprinkleLengthFactor / 2;
    final paint = Paint()
      ..strokeWidth = thickness * _sprinkleWidthFactor
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < count; i++) {
      final angle = _startAngle + sweep * (i + 0.5) / count;
      final distance = radius + thickness * _radialOffsets[i % _radialOffsets.length];
      final position = center + Offset(math.cos(angle), math.sin(angle)) * distance;
      final direction = angle + _tilts[i % _tilts.length];
      final halfStroke = Offset(math.cos(direction), math.sin(direction)) * halfLength;
      paint.color = sprinkleColors[i % sprinkleColors.length];
      canvas.drawLine(position - halfStroke, position + halfStroke, paint);
    }
  }

  @override
  bool shouldRepaint(_PointsRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.ringColor != ringColor || oldDelegate.trackColor != trackColor;
}
