import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../theme/app_motion.dart';

/// Page transitions used by the router.
abstract final class AppPageTransitions {
  static const Duration _sharedAxisDuration = Duration(milliseconds: 420);
  static const Duration _fadeScaleDuration = Duration(milliseconds: 380);
  static const double _fadeScaleFrom = 0.96;

  /// Steps of one flow (onboarding → registration → welcome): the new page
  /// slides in from the side while the old one slides away and fades out.
  static Page<void> sharedAxis(GoRouterState state, Widget child) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _sharedAxisDuration,
    reverseTransitionDuration: _sharedAxisDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        _SharedAxisX(animation: animation, secondaryAnimation: secondaryAnimation, child: child),
  );

  /// A page opened on top (product detail): fades in while growing slightly,
  /// so a hero image flying in stays the focus.
  static Page<void> fadeScale(GoRouterState state, Widget child) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _fadeScaleDuration,
    reverseTransitionDuration: _fadeScaleDuration,
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
  static const Interval _fadeIn = Interval(0.3, 1, curve: Curves.easeOut);
  static const Interval _fadeOut = Interval(0, 0.3, curve: Curves.easeIn);
  static const Curve _motion = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    final direction = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
    final fill = Theme.of(context).colorScheme.surface;
    return AnimatedBuilder(
      animation: Listenable.merge([animation, secondaryAnimation]),
      child: child,
      builder: (context, child) {
        final enter = animation.value;
        final exit = secondaryAnimation.value;
        final dx = ((1 - _motion.transform(enter)) - _motion.transform(exit)) * _slideDistance * direction;
        final opacity = _fadeIn.transform(enter) * (1 - _fadeOut.transform(exit));
        return ColoredBox(
          // Only a page being covered paints the fill behind itself.
          color: exit > 0 ? fill : fill.withValues(alpha: 0),
          child: Opacity(
            opacity: opacity,
            child: Transform.translate(offset: Offset(dx, 0), child: child),
          ),
        );
      },
    );
  }
}
