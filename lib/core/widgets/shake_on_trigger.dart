import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

/// Shakes [child] sideways each time [trigger] changes (e.g. a wrong OTP).
class ShakeOnTrigger extends StatefulWidget {
  const ShakeOnTrigger({super.key, required this.trigger, required this.child});

  /// Any change in this value starts one shake.
  final int trigger;
  final Widget child;

  @override
  State<ShakeOnTrigger> createState() => _ShakeOnTriggerState();
}

class _ShakeOnTriggerState extends State<ShakeOnTrigger> with SingleTickerProviderStateMixin {
  static const double _amplitude = 10;
  static const int _wiggles = 4;

  late final AnimationController _controller = AnimationController(vsync: this, duration: AppDurations.shake);

  @override
  void didUpdateWidget(ShakeOnTrigger oldWidget) {
    super.didUpdateWidget(oldWidget);
    // With reduced motion the error colour and haptic are cue enough.
    if (oldWidget.trigger != widget.trigger && !context.reduceMotion) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) => Transform.translate(offset: Offset(_offset(_controller.value), 0), child: child),
    );
  }

  /// A sine wave that fades out as the animation ends.
  double _offset(double progress) => math.sin(progress * math.pi * 2 * _wiggles) * _amplitude * (1 - progress);
}
