import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/donut_circle.dart';
import '../../../../core/widgets/entrance_animation.dart';

/// Collage of donut circles at the top of onboarding; edge circles are cropped
/// and the bottom fades into the background. Give it a bounded size.
class OnboardingHero extends StatelessWidget {
  const OnboardingHero({super.key});

  static const double _fadeStart = 0.7;

  /// How far out (as a share of the circle's size per unit of alignment) a circle starts.
  static const double _driftDistance = 0.35;
  static const double _driftScaleFrom = 0.8;

  @override
  Widget build(BuildContext context) {
    final fadeColor = Theme.of(context).colorScheme.surface;
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [_fadeStart, 1],
        colors: [fadeColor, fadeColor.withValues(alpha: 0)],
      ).createShader(bounds),
      child: ClipRect(
        child: Stack(fit: StackFit.expand, children: _circles(context.palette)),
      ),
    );
  }

  /// Each circle drifts in from beyond its nearest edge, one after another.
  List<Widget> _circles(AppPalette palette) => [
    for (final (index, circle) in _HeroCircle.layout.indexed)
      Align(
        alignment: circle.alignment,
        child: FractionallySizedBox(
          widthFactor: circle.widthFactor,
          child: EntranceAnimation(
            delay: AppDurations.onboardingDriftStep * index,
            duration: AppDurations.onboardingDrift,
            offset: Offset(circle.alignment.x, circle.alignment.y) * _driftDistance,
            scaleFrom: _driftScaleFrom,
            child: DonutCircle(backgroundColor: palette.decorativeAt(circle.colorIndex), imagePath: circle.imagePath),
          ),
        ),
      ),
  ];
}

/// Position, size (as a fraction of the hero width) and colour of each circle.
class _HeroCircle {
  const _HeroCircle(this.alignment, this.widthFactor, this.colorIndex, this.imagePath);

  final Alignment alignment;
  final double widthFactor;
  final int colorIndex;
  final String imagePath;

  static const List<_HeroCircle> layout = [
    _HeroCircle(Alignment(-1.35, -1.1), 0.36, 3, AppImages.donutChocolateBiscoff),
    _HeroCircle(Alignment(1.35, -1.05), 0.3, 4, AppImages.donutVanillaCaramel),
    _HeroCircle(Alignment(0, -0.5), 0.55, 0, AppImages.donutMarshmallow),
    _HeroCircle(Alignment(-1.4, 0.4), 0.38, 1, AppImages.donutVanillaCaramel),
    _HeroCircle(Alignment(1.4, 0.5), 0.4, 1, AppImages.donutChocolateBiscoff),
    _HeroCircle(Alignment(0, 1.3), 0.5, 2, AppImages.donutMarshmallow),
  ];
}
