import 'dart:math' as math;

import 'package:flutter/rendering.dart';

/// Banner background with faint sprinkle dashes scattered across it.
/// Positions come from a fixed seed so the pattern never flickers.
class ConfettiPainter extends CustomPainter {
  const ConfettiPainter({required this.background, required this.dash});

  final Color background;
  final Color dash;

  static const int _seed = 7;
  static const int _dashCount = 26;
  static const double _dashLength = 14;
  static const double _dashWidth = 4;
  static const double _dashAlpha = 0.14;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = background);
    final random = math.Random(_seed);
    final paint = Paint()
      ..color = dash.withValues(alpha: _dashAlpha)
      ..strokeWidth = _dashWidth
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < _dashCount; i++) {
      final start = Offset(random.nextDouble() * size.width, random.nextDouble() * size.height);
      final direction = Offset.fromDirection(random.nextDouble() * math.pi, _dashLength);
      canvas.drawLine(start, start + direction, paint);
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => oldDelegate.background != background || oldDelegate.dash != dash;
}
