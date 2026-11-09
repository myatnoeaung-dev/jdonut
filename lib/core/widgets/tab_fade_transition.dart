import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

/// Fades and slightly shrinks the page at [index] of a [TabBarView] as it moves
/// away from the selected tab, so switching tabs reads as a cross-fade on top
/// of the slide. Follows swipes as well as taps. Skipped when the user prefers
/// less motion (the plain slide remains, as it follows the finger).
class TabFadeTransition extends StatelessWidget {
  const TabFadeTransition({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  static const double _awayScale = 0.95;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    // Fade/Scale transitions update their layers without repainting the page.
    final presence = DefaultTabController.of(context).animation!.drive(_Presence(index));
    return FadeTransition(
      opacity: presence.drive(CurveTween(curve: AppCurves.accelerate)),
      child: ScaleTransition(
        scale: presence.drive(Tween(begin: _awayScale, end: 1)),
        child: child,
      ),
    );
  }
}

/// 1 when the tab position is exactly [index], falling to 0 one tab away.
class _Presence extends Animatable<double> {
  const _Presence(this.index);

  final int index;

  @override
  double transform(double t) => (1 - (t - index).abs()).clamp(0, 1).toDouble();
}
