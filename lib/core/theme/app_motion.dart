import 'package:flutter/widgets.dart';

/// Every animation length in the app, in one place. Grouped by where they're
/// used; shared ones first.
///
/// Respect "reduce motion" by passing a duration through [ReduceMotion.motion]
/// (or [PlayOnce.playUnlessReduced] for controllers).
abstract final class AppDurations {
  // Shared
  /// Press feedback on buttons.
  static const Duration press = Duration(milliseconds: 110);

  /// Tab indicators, colour changes, small size changes.
  static const Duration short = Duration(milliseconds: 280);

  /// A widget sliding or fading into place.
  static const Duration entrance = Duration(milliseconds: 450);

  /// Gap between items that enter one after another.
  static const Duration staggerStep = Duration(milliseconds: 90);

  /// One sideways shake of a field with a wrong value.
  static const Duration shake = Duration(milliseconds: 450);

  /// One sweep of the loading skeleton's highlight.
  static const Duration shimmerSweep = Duration(milliseconds: 1300);

  /// CONTINUE morphing into (and out of) its round loading state.
  static const Duration buttonMorph = Duration(milliseconds: 350);

  // Page transitions
  static const Duration sharedAxis = Duration(milliseconds: 420);
  static const Duration fadeScale = Duration(milliseconds: 380);

  // Onboarding
  static const Duration onboardingDrift = Duration(milliseconds: 1100);
  static const Duration onboardingDriftStep = Duration(milliseconds: 90);

  /// When the title and buttons start entering under the drifting donuts.
  static const Duration onboardingSettle = Duration(milliseconds: 500);

  // Registration
  /// Title and fields enter just after the page slides in.
  static const Duration stepContentDelay = Duration(milliseconds: 150);

  /// The progress ring waits for the page transition before it moves.
  static const Duration registrationRingDelay = Duration(milliseconds: 300);
  static const Duration registrationRingSweep = Duration(milliseconds: 600);

  /// The full ring filling in and turning into a check.
  static const Duration registrationRingMorph = Duration(milliseconds: 700);

  // Welcome
  static const Duration welcomeTileSlide = Duration(milliseconds: 650);
  static const Duration welcomeTileStep = Duration(milliseconds: 110);

  /// Between the title fading up and the button following it.
  static const Duration welcomeButtonDelay = Duration(milliseconds: 150);

  // Home
  /// The tier hexagon pops and the bell slides in after the header appears.
  static const Duration homeDecorationDelay = Duration(milliseconds: 250);
  static const Duration homeSectionStep = Duration(milliseconds: 120);
  static const Duration carouselInterval = Duration(seconds: 4);
  static const Duration carouselPauseAfterSwipe = Duration(seconds: 6);
  static const Duration carouselSlide = Duration(milliseconds: 600);

  // Product detail
  /// The description and cart bar wait for the page transition.
  static const Duration productDetailsDelay = Duration(milliseconds: 250);

  // Rewards
  /// The points ring sweep and count-up.
  static const Duration ringSweep = Duration(milliseconds: 1400);

  /// Tiers appearing, the current one popping, then its line filling.
  static const Duration tierLadder = Duration(milliseconds: 1600);

  /// Progress art filling in (donut slices, coffee arc).
  static const Duration progressFill = Duration(milliseconds: 900);

  /// One "look at me" pulse of a ready EARN button.
  static const Duration attentionPulse = Duration(milliseconds: 700);
  static const Duration rewardsBadgePopDelay = Duration(milliseconds: 350);
  static const Duration rewardsBadgePop = Duration(milliseconds: 700);
}

/// Every animation curve in the app, in one place.
abstract final class AppCurves {
  /// Fast start, gentle stop: most things moving into place.
  static const Curve emphasized = Curves.easeOutCubic;

  /// Slow start and stop: things moving from one place to another.
  static const Curve standard = Curves.easeInOutCubic;

  /// Gentle stop, for fading in.
  static const Curve decelerate = Curves.easeOut;

  /// Gentle start, for fading out.
  static const Curve accelerate = Curves.easeIn;

  /// Constant speed, for timelines split into parts.
  static const Curve linear = Curves.linear;

  /// Slight overshoot, for things that pop into place.
  static const Curve pop = Curves.easeOutBack;

  /// Springy overshoot, for small badges.
  static const Curve bounce = Curves.elasticOut;
}

extension ReduceMotion on BuildContext {
  /// The user asked the system to reduce motion; animations jump to the end.
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;

  /// [duration], or zero (an instant change) when the user prefers less motion.
  Duration motion(Duration duration) => reduceMotion ? Duration.zero : duration;
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
Interval delayedInterval(Duration delay, Duration total, {Curve curve = AppCurves.linear}) {
  final start = total.inMicroseconds == 0 ? 0.0 : delay.inMicroseconds / total.inMicroseconds;
  return Interval(start.clamp(0, 1).toDouble(), 1, curve: curve);
}
