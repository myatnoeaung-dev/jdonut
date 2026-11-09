import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../theme/app_motion.dart';

/// Page transitions used by the router.
abstract final class AppPageTransitions {
  static const double _fadeScaleFrom = 0.96;

  /// Steps of one flow (onboarding → registration → welcome): the new page
  /// slides in from the side while the old one slides away and fades out.
  static Page<void> sharedAxis(GoRouterState state, Widget child) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppDurations.sharedAxis,
    reverseTransitionDuration: AppDurations.sharedAxis,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        _SharedAxisX(animation: animation, secondaryAnimation: secondaryAnimation, child: child),
  );

  /// A page opened on top (product detail): fades in while growing slightly,
  /// so a hero image flying in stays the focus.
  static Page<void> fadeScale(GoRouterState state, Widget child) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppDurations.fadeScale,
    reverseTransitionDuration: AppDurations.fadeScale,
    transitionsBuilder: (context, animation, _, child) {
      if (context.reduceMotion) return child;
      final curved = animation.drive(CurveTween(curve: AppCurves.emphasized));
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: curved.drive(Tween(begin: _fadeScaleFrom, end: 1)),
          child: child,
        ),
      );
    },
  );
}

/// Horizontal shared-axis transition. The incoming page fades in from a short
/// offset; the page it covers moves the other way and fades out over a plain
/// fill, so the two never show through each other.
class _SharedAxisX extends StatelessWidget {
  const _SharedAxisX({required this.animation, required this.secondaryAnimation, required this.child});

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  static const double _slideDistance = 30;
  static const Interval _fadeIn = Interval(0.3, 1, curve: AppCurves.decelerate);
  static const Curve _motion = AppCurves.standard;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    final direction = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
    final fill = Theme.of(context).colorScheme.surface;
    // Fades run on their own layers (no page repaint); only the offset rebuilds.
    final faded = FadeTransition(
      opacity: animation.drive(CurveTween(curve: _fadeIn)),
      child: FadeTransition(opacity: secondaryAnimation.drive(_FadeOut()), child: child),
    );
    return AnimatedBuilder(
      animation: Listenable.merge([animation, secondaryAnimation]),
      child: faded,
      builder: (context, child) {
        final exit = secondaryAnimation.value;
        final dx = ((1 - _motion.transform(animation.value)) - _motion.transform(exit)) * _slideDistance * direction;
        return ColoredBox(
          // Only a page being covered paints the fill behind itself.
          color: exit > 0 ? fill : fill.withValues(alpha: 0),
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
    );
  }
}

/// 1 → 0 over the first 30% of the covering page's arrival.
class _FadeOut extends Animatable<double> {
  const _FadeOut();

  static const Interval _interval = Interval(0, 0.3, curve: AppCurves.accelerate);

  @override
  double transform(double t) => 1 - _interval.transform(t);
}
