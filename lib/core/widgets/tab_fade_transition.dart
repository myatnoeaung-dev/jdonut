import 'package:flutter/material.dart';

/// Fades and slightly shrinks the page at [index] of a [TabBarView] as it moves
/// away from the selected tab, so switching tabs reads as a cross-fade on top
/// of the slide. Follows swipes as well as taps.
class TabFadeTransition extends StatelessWidget {
  const TabFadeTransition({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  static const double _awayScale = 0.95;

  @override
  Widget build(BuildContext context) {
    final animation = DefaultTabController.of(context).animation!;
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final presence = (1 - (animation.value - index).abs()).clamp(0, 1).toDouble();
        return Opacity(
          opacity: Curves.easeIn.transform(presence),
          child: Transform.scale(scale: _awayScale + (1 - _awayScale) * presence, child: child),
        );
      },
    );
  }
}
