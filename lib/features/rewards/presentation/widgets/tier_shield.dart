import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../domain/entities/member.dart';

/// Shield badge in the tier's colour with its first letter and one star per
/// tier above Bronze (Silver ★, Gold ★★, Platinum ★★★).
class TierShield extends StatelessWidget {
  const TierShield({super.key, required this.tier, required this.name});

  final MemberTier tier;
  final String name;

  /// How much darker the letter and stars are than the shield.
  static const double _inkShade = 0.45;
  static const double _letterTop = 0.38;

  @override
  Widget build(BuildContext context) {
    final color = tierColor(context.palette, tier);
    final ink = Color.lerp(color, Theme.of(context).colorScheme.onSurface, _inkShade)!;
    return ExcludeSemantics(
      child: SizedBox(
        width: AppSizes.tierLadderBadge,
        height: AppSizes.tierLadderBadgeHeight,
        child: CustomPaint(
          painter: _ShieldPainter(
            color: color,
            ink: ink,
            stars: tier.index,
            surface: Theme.of(context).colorScheme.surface,
          ),
          child: Align(
            alignment: const Alignment(0, _letterTop),
            child: Text(
              name.characters.first.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ink, fontWeight: FontWeight.w800),
              textScaler: TextScaler.noScaling, // the badge is a fixed-size icon
            ),
          ),
        ),
      ),
    );
  }

  static Color tierColor(AppPalette palette, MemberTier tier) => switch (tier) {
    MemberTier.bronze => palette.tierBronze,
    MemberTier.silver => palette.tierSilver,
    MemberTier.gold => palette.tierGold,
    MemberTier.platinum => palette.tierPlatinum,
  };
}

class _ShieldPainter extends CustomPainter {
  const _ShieldPainter({required this.color, required this.ink, required this.stars, required this.surface});

  final Color color;
  final Color ink;
  final int stars;
  final Color surface;

  /// Lighter at the top, like the design's glossy badges.
  static const double _gloss = 0.4;
  static const double _outlineShade = 0.15;
  static const double _outlineWidth = 1.2;

  // Shield outline as fractions of the badge size.
  static const double _shoulder = 0.16;
  static const double _sideBottom = 0.55;
  static const double _curve = 0.86;

  // Stars: centre height, size and gap, as fractions of the badge width.
  static const double _starsY = 0.24;
  static const double _starRadius = 0.09;
  static const double _starGap = 0.2;
  static const double _innerRadiusFactor = 0.45;

  @override
  void paint(Canvas canvas, Size size) {
    final shield = _shieldPath(size);
    final light = Color.lerp(color, surface, _gloss)!;
    canvas.drawPath(
      shield,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [light, color],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      shield,
      Paint()
        ..color = Color.lerp(color, ink, _outlineShade)!
        ..style = PaintingStyle.stroke
        ..strokeWidth = _outlineWidth,
    );
    _paintStars(canvas, size);
  }

  Path _shieldPath(Size size) {
    final w = size.width;
    final h = size.height;
    return Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w, h * _shoulder)
      ..lineTo(w, h * _sideBottom)
      ..quadraticBezierTo(w, h * _curve, w / 2, h)
      ..quadraticBezierTo(0, h * _curve, 0, h * _sideBottom)
      ..lineTo(0, h * _shoulder)
      ..close();
  }

  void _paintStars(Canvas canvas, Size size) {
    if (stars <= 0) return;
    final paint = Paint()..color = ink;
    final radius = size.width * _starRadius;
    final gap = size.width * _starGap;
    final firstX = size.width / 2 - gap * (stars - 1) / 2;
    for (var i = 0; i < stars; i++) {
      canvas.drawPath(_star(Offset(firstX + gap * i, size.height * _starsY), radius), paint);
    }
  }

  /// A five-pointed star centred on [center].
  static Path _star(Offset center, double radius) {
    const points = 5;
    final path = Path();
    for (var i = 0; i < points * 2; i++) {
      final r = i.isEven ? radius : radius * _innerRadiusFactor;
      final angle = -math.pi / 2 + math.pi * i / points;
      final point = center + Offset(math.cos(angle), math.sin(angle)) * r;
      i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(_ShieldPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.ink != ink || oldDelegate.stars != stars;
}
