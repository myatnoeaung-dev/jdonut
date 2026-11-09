import 'package:flutter/widgets.dart';

/// Animation lengths shared across the app.
abstract final class AppDurations {
  /// Press feedback on buttons.
  static const Duration press = Duration(milliseconds: 110);

  /// Tab indicators and colour changes.
  static const Duration short = Duration(milliseconds: 280);

  /// A widget sliding or fading into place.
  static const Duration entrance = Duration(milliseconds: 450);

  /// Progress art filling in (donut quarters, coffee arc, tier line).
  static const Duration progressFill = Duration(milliseconds: 900);

  /// The points ring sweep and count-up.
  static const Duration ringSweep = Duration(milliseconds: 1400);

  /// Gap between items that enter one after another.
  static const Duration staggerStep = Duration(milliseconds: 90);

  /// One "look at me" pulse of a ready button.
  static const Duration attentionPulse = Duration(milliseconds: 700);
}

/// Animation curves shared across the app.
abstract final class AppCurves {
  static const Curve emphasized = Curves.easeOutCubic;

  /// Slight overshoot, for things that pop into place.
  static const Curve pop = Curves.easeOutBack;

  /// Springy overshoot, for small badges.
  static const Curve bounce = Curves.elasticOut;
}

extension ReduceMotion on BuildContext {
  /// The user asked the system to reduce motion; animations jump to the end.
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;
}

extension PlayOnce on AnimationController {
  /// Runs forward, or jumps to the end when the user prefers less motion.
  void playUnlessReduced(BuildContext context) {
    if (context.reduceMotion) {
      value = upperBound;
    } else {
      forward();
    }
  }
}

/// [Interval] for something that waits [delay] inside an animation of [total].
Interval delayedInterval(Duration delay, Duration total, {Curve curve = Curves.linear}) {
  final start = total.inMicroseconds == 0 ? 0.0 : delay.inMicroseconds / total.inMicroseconds;
  return Interval(start.clamp(0, 1).toDouble(), 1, curve: curve);
}
