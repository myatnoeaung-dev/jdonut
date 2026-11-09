import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';

/// Ring at the top right of each registration step. Fills a quarter per step:
/// on entry it sweeps from the previous step's share to this one's
/// (25% → 50% → 75% → 100%). On the last step it then fills in and morphs
/// into a check.
class RegistrationProgressRing extends StatefulWidget {
  const RegistrationProgressRing({super.key, required this.step, required this.totalSteps});

  final int step;
  final int totalSteps;

  @override
  State<RegistrationProgressRing> createState() => _RegistrationProgressRingState();
}

class _RegistrationProgressRingState extends State<RegistrationProgressRing> with SingleTickerProviderStateMixin {
  late final bool _isLastStep = widget.step >= widget.totalSteps;
  late final Duration _total =
      AppDurations.registrationRingDelay +
      AppDurations.registrationRingSweep +
      (_isLastStep ? AppDurations.registrationRingMorph : Duration.zero);
  late final AnimationController _controller = AnimationController(vsync: this, duration: _total);
  late final Animation<double> _sweepProgress = _controller.drive(
    CurveTween(
      curve: _segment(AppDurations.registrationRingDelay, AppDurations.registrationRingSweep, AppCurves.emphasized),
    ),
  );
  late final Animation<double> _morphProgress = _controller.drive(
    CurveTween(
      curve: _segment(
        AppDurations.registrationRingDelay + AppDurations.registrationRingSweep,
        AppDurations.registrationRingMorph,
        AppCurves.linear,
      ),
    ),
  );
  bool _started = false;

  Interval _segment(Duration start, Duration length, Curve curve) => Interval(
    start.inMicroseconds / _total.inMicroseconds,
    ((start + length).inMicroseconds / _total.inMicroseconds).clamp(0, 1).toDouble(),
    curve: curve,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _controller.playUnlessReduced(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final from = (widget.step - 1) / widget.totalSteps;
    final to = widget.step / widget.totalSteps;
    return Semantics(
      label: context.l10n.registrationStep(widget.step, widget.totalSteps),
      child: SizedBox.square(
        dimension: AppSizes.progressRing,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => CustomPaint(
            painter: _MorphingRingPainter(
              progress: lerpDouble(from, to, _sweepProgress.value)!.clamp(0, 1).toDouble(),
              morph: _isLastStep ? _morphProgress.value : 0,
              color: palette.progress,
              trackColor: palette.progressTrack,
              checkColor: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Track + progress arc. As [morph] runs 0 → 1 a disc grows to fill the ring
/// (first half), then a check is drawn on it with a small bounce (second half).
class _MorphingRingPainter extends CustomPainter {
  const _MorphingRingPainter({
    required this.progress,
    required this.morph,
    required this.color,
    required this.trackColor,
    required this.checkColor,
  });

  final double progress;
  final double morph;
  final Color color;
  final Color trackColor;
  final Color checkColor;

  static const double _startAngle = -math.pi / 2;
  static const double _fullTurn = 2 * math.pi;
  static const Interval _fill = Interval(0, 0.5, curve: AppCurves.emphasized);
  static const Interval _draw = Interval(0.5, 1, curve: AppCurves.decelerate);
  static const double _bounce = 0.12;
  static const double _checkStrokeFactor = 0.1;

  /// The check's three points as fractions of the ring's size.
  static const List<Offset> _checkPoints = [Offset(0.28, 0.52), Offset(0.44, 0.67), Offset(0.72, 0.36)];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final checkProgress = _draw.transform(morph);
    // Bounces once while the check is drawn.
    final scale = 1 + _bounce * math.sin(math.pi * checkProgress);
    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..scale(scale)
      ..translate(-center.dx, -center.dy);
    _paintRing(canvas, size);
    _paintDisc(canvas, center, size.shortestSide / 2 * _fill.transform(morph));
    if (checkProgress > 0) _paintCheck(canvas, size, checkProgress);
    canvas.restore();
  }

  void _paintRing(Canvas canvas, Size size) {
    final arcRect = (Offset.zero & size).deflate(AppSizes.progressStroke / 2);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSizes.progressStroke;
    canvas.drawArc(arcRect, 0, _fullTurn, false, stroke..color = trackColor);
    canvas.drawArc(arcRect, _startAngle, _fullTurn * progress, false, stroke..color = color);
  }

  void _paintDisc(Canvas canvas, Offset center, double radius) {
    if (radius > 0) canvas.drawCircle(center, radius, Paint()..color = color);
  }

  void _paintCheck(Canvas canvas, Size size, double drawn) {
    final points = [for (final point in _checkPoints) Offset(point.dx * size.width, point.dy * size.height)];
    final check = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      check.lineTo(point.dx, point.dy);
    }
    final metric = check.computeMetrics().first;
    final paint = Paint()
      ..color = checkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.shortestSide * _checkStrokeFactor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(metric.extractPath(0, metric.length * drawn), paint);
  }

  @override
  bool shouldRepaint(_MorphingRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.morph != morph ||
      oldDelegate.color != color ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.checkColor != checkColor;
}
