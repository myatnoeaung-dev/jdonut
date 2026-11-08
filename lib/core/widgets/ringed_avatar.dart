import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_palette.dart';

/// Member photo with an orange arc around its top-right. Shows [initial]
/// until the photo at [imagePath] exists.
class RingedAvatar extends StatelessWidget {
  const RingedAvatar({super.key, required this.imagePath, required this.initial});

  final String imagePath;
  final String initial;

  static const double size = AppSizes.avatar + 2 * (AppSizes.avatarRingGap + AppSizes.avatarRingStroke);

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final colors = Theme.of(context).colorScheme;
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _AvatarArcPainter(start: palette.badgeLight, end: palette.badge),
        child: Center(
          child: CircleAvatar(
            radius: AppSizes.avatar / 2,
            backgroundColor: colors.secondary,
            foregroundImage: AssetImage(imagePath),
            onForegroundImageError: (_, _) {},
            child: Text(initial, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.onSecondary)),
          ),
        ),
      ),
    );
  }
}

class _AvatarArcPainter extends CustomPainter {
  const _AvatarArcPainter({required this.start, required this.end});

  final Color start;
  final Color end;

  static const double _startAngle = -math.pi * 0.62;
  static const double _sweepAngle = math.pi * 0.95;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(AppSizes.avatarRingStroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppSizes.avatarRingStroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: _startAngle,
        endAngle: _startAngle + _sweepAngle,
        colors: [start.withValues(alpha: 0), end],
      ).createShader(rect);
    canvas.drawArc(rect, _startAngle, _sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(_AvatarArcPainter oldDelegate) => oldDelegate.start != start || oldDelegate.end != end;
}
