import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// Large rounded hexagon with the tier star, drawn behind the Home header.
/// Purely decorative.
class TierHexagonBadge extends StatelessWidget {
  const TierHexagonBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: AppSizes.tierHexagon,
        child: CustomPaint(
          painter: _HexagonPainter(
            fill: palette.tierBadgeFill,
            outline: Theme.of(context).colorScheme.surface,
            edgeStart: palette.badge,
            edgeEnd: palette.badgeLight,
          ),
          child: Center(
            child: Icon(Icons.star_rounded, size: AppSizes.tierStar, color: palette.tierIcon),
          ),
        ),
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  const _HexagonPainter({required this.fill, required this.outline, required this.edgeStart, required this.edgeEnd});

  final Color fill;
  final Color outline;
  final Color edgeStart;
  final Color edgeEnd;

  static const int _sides = 6;
  static const double _cornerRadiusFactor = 0.16;
  static const double _outlineWidth = 6;
  static const double _edgeWidth = 10;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 2 - _edgeWidth;
    final path = _roundedHexagon(size.center(Offset.zero), radius);
    final edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _edgeWidth
      ..shader = LinearGradient(colors: [edgeStart, edgeEnd.withValues(alpha: 0)]).createShader(Offset.zero & size);
    canvas
      ..drawPath(path, edge)
      ..drawPath(path, Paint()..color = fill)
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _outlineWidth
          ..color = outline,
      );
  }

  /// Pointy-top hexagon whose corners are rounded with quadratic curves.
  Path _roundedHexagon(Offset center, double radius) {
    final corners = [
      for (var i = 0; i < _sides; i++) center + Offset.fromDirection(-math.pi / 2 + i * 2 * math.pi / _sides, radius),
    ];
    final path = Path();
    for (var i = 0; i < _sides; i++) {
      final corner = corners[i];
      final before = Offset.lerp(corner, corners[(i + _sides - 1) % _sides], _cornerRadiusFactor)!;
      final after = Offset.lerp(corner, corners[(i + 1) % _sides], _cornerRadiusFactor)!;
      i == 0 ? path.moveTo(before.dx, before.dy) : path.lineTo(before.dx, before.dy);
      path.quadraticBezierTo(corner.dx, corner.dy, after.dx, after.dy);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(_HexagonPainter oldDelegate) =>
      oldDelegate.fill != fill || oldDelegate.outline != outline || oldDelegate.edgeStart != edgeStart;
}
