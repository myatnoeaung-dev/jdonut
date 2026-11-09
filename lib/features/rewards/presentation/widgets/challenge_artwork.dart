import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/reward_challenge.dart';

/// The product photo showing the challenge's progress, filled in after [delay]:
/// - eat: the donut colours in slice by slice (one slice per item, e.g. 1/4);
/// - drink: an orange arc around the cup fills (e.g. 9/12).
class ChallengeArtwork extends StatefulWidget {
  const ChallengeArtwork({super.key, required this.challenge, this.delay = Duration.zero});

  final RewardChallenge challenge;
  final Duration delay;

  @override
  State<ChallengeArtwork> createState() => _ChallengeArtworkState();
}

class _ChallengeArtworkState extends State<ChallengeArtwork> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.delay + AppDurations.progressFill,
  );
  late final Animation<double> _fill = _controller.drive(
    CurveTween(curve: delayedInterval(widget.delay, widget.delay + AppDurations.progressFill)),
  );
  bool _started = false;

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
    final challenge = widget.challenge;
    return switch (challenge.kind) {
      ChallengeKind.eat => _DonutSlices(challenge: challenge, fill: _fill),
      ChallengeKind.drink => _CoffeeArc(challenge: challenge, fill: _fill),
    };
  }
}

/// Grey donut photo with the coloured photo revealed slice by slice on top.
class _DonutSlices extends StatelessWidget {
  const _DonutSlices({required this.challenge, required this.fill});

  final RewardChallenge challenge;

  /// 0 to 1 over the fill animation.
  final Animation<double> fill;

  /// Standard luminance weights: turns the photo grey.
  static const List<double> _greyscale = [
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0, 0, 0, 1, 0, //
  ];

  /// Keeps the not-yet-earned part visible but clearly muted.
  static const double _greyOpacity = 0.45;

  @override
  Widget build(BuildContext context) {
    final photo = AppNetworkImage(path: challenge.imageUrl, semanticLabel: challenge.title);
    final slices = math.max(1, challenge.goal);
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeSemantics(
          child: Opacity(
            opacity: _greyOpacity,
            child: ColorFiltered(colorFilter: const ColorFilter.matrix(_greyscale), child: photo),
          ),
        ),
        AnimatedBuilder(
          animation: fill,
          child: photo,
          builder: (context, child) => ClipPath(
            clipper: _SliceClipper(sweep: _sweep(slices, fill.value)),
            child: child,
          ),
        ),
        IgnorePointer(
          child: CustomPaint(
            painter: _SliceLinesPainter(slices: slices, color: Theme.of(context).colorScheme.surface),
          ),
        ),
      ],
    );
  }

  /// Fills one slice at a time, each with its own ease, up to the progress.
  double _sweep(int slices, double t) {
    final shownSlices = challenge.progress.clamp(0, slices) * t;
    final whole = shownSlices.floor();
    final partial = AppCurves.emphasized.transform(shownSlices - whole);
    return _fullTurn * (whole + partial) / slices;
  }
}

const double _fullTurn = 2 * math.pi;
const double _twelveOClock = -math.pi / 2;

/// A pie slice from 12 o'clock, clockwise by [sweep] radians.
class _SliceClipper extends CustomClipper<Path> {
  const _SliceClipper({required this.sweep});

  final double sweep;

  @override
  Path getClip(Size size) {
    final bounds = Offset.zero & size;
    if (sweep >= _fullTurn) return Path()..addRect(bounds);
    final center = bounds.center;
    // Larger than the box, so the slice reaches the corners.
    final reach = Rect.fromCircle(center: center, radius: size.longestSide);
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(reach, _twelveOClock, sweep, false)
      ..close();
  }

  @override
  bool shouldReclip(_SliceClipper oldClipper) => oldClipper.sweep != sweep;
}

/// Thin cuts from the centre that split the donut into [slices].
class _SliceLinesPainter extends CustomPainter {
  const _SliceLinesPainter({required this.slices, required this.color});

  final int slices;
  final Color color;

  static const double _strokeWidth = 2;

  /// Lines reach just past the photo's edge.
  static const double _reachFactor = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    if (slices < 2) return;
    final center = size.center(Offset.zero);
    final length = size.shortestSide * _reachFactor;
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth;
    for (var i = 0; i < slices; i++) {
      final angle = _twelveOClock + _fullTurn * i / slices;
      canvas.drawLine(center, center + Offset(math.cos(angle), math.sin(angle)) * length, paint);
    }
  }

  @override
  bool shouldRepaint(_SliceLinesPainter oldDelegate) => oldDelegate.slices != slices || oldDelegate.color != color;
}

/// Cup photo inside a 270° gauge split into one segment per cup.
class _CoffeeArc extends StatelessWidget {
  const _CoffeeArc({required this.challenge, required this.fill});

  final RewardChallenge challenge;
  final Animation<double> fill;

  static const EdgeInsets _insideArc = EdgeInsets.all(AppSpacing.md);

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return AnimatedBuilder(
      animation: fill,
      child: Padding(
        padding: _insideArc,
        child: AppNetworkImage(path: challenge.imageUrl, semanticLabel: challenge.title),
      ),
      builder: (context, child) => CustomPaint(
        painter: _ProgressArcPainter(
          completion: challenge.completion * fill.value,
          segments: challenge.goal,
          color: palette.badge,
          trackColor: palette.disabledFill,
          gapColor: Theme.of(context).colorScheme.surface,
        ),
        child: child,
      ),
    );
  }
}

/// A 270° gauge opening at the bottom, filled clockwise from the lower left,
/// with small gaps between [segments].
class _ProgressArcPainter extends CustomPainter {
  const _ProgressArcPainter({
    required this.completion,
    required this.segments,
    required this.color,
    required this.trackColor,
    required this.gapColor,
  });

  final double completion;
  final int segments;
  final Color color;
  final Color trackColor;
  final Color gapColor;

  static const double _startAngle = 0.75 * math.pi; // lower left
  static const double _gaugeSweep = 1.5 * math.pi;
  static const double _strokeWidth = 8;
  static const double _gapWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_strokeWidth / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _startAngle, _gaugeSweep, false, paint..color = trackColor);
    if (completion > 0) canvas.drawArc(rect, _startAngle, _gaugeSweep * completion, false, paint..color = color);
    _paintGaps(canvas, rect);
  }

  void _paintGaps(Canvas canvas, Rect rect) {
    final radius = rect.width / 2;
    final paint = Paint()
      ..color = gapColor
      ..strokeWidth = _gapWidth;
    for (var i = 1; i < segments; i++) {
      final angle = _startAngle + _gaugeSweep * i / segments;
      final direction = Offset(math.cos(angle), math.sin(angle));
      final inner = rect.center + direction * (radius - _strokeWidth);
      canvas.drawLine(inner, rect.center + direction * (radius + _strokeWidth), paint);
    }
  }

  @override
  bool shouldRepaint(_ProgressArcPainter oldDelegate) =>
      oldDelegate.completion != completion || oldDelegate.segments != segments || oldDelegate.color != color;
}
