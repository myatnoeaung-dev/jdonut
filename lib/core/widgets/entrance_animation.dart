import 'package:flutter/widgets.dart';

import '../theme/app_motion.dart';

/// Fades [child] in after [delay] while it slides from [offset] (a fraction of
/// its own size) and grows from [scaleFrom]. Plays once when first built; give
/// it a new key to play again.
class EntranceAnimation extends StatefulWidget {
  const EntranceAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppDurations.entrance,
    this.offset = defaultOffset,
    this.scaleFrom = 1,
    this.curve = AppCurves.emphasized,
  });

  /// A short rise from below.
  static const Offset defaultOffset = Offset(0, 0.12);

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final double scaleFrom;
  final Curve curve;

  /// Wraps each of [children] so they enter one after another, [step] apart,
  /// starting after [delay].
  static List<Widget> staggered(
    List<Widget> children, {
    Duration delay = Duration.zero,
    Duration step = AppDurations.staggerStep,
    Offset offset = defaultOffset,
  }) => [
    for (final (index, child) in children.indexed)
      EntranceAnimation(delay: delay + step * index, offset: offset, child: child),
  ];

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.delay + widget.duration,
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _controller.playUnlessReduced(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.delay + widget.duration;
    // Opacity uses its own curve: springy curves overshoot past 1.
    final fade = _controller.drive(CurveTween(curve: delayedInterval(widget.delay, total, curve: Curves.easeOut)));
    final motion = _controller.drive(CurveTween(curve: delayedInterval(widget.delay, total, curve: widget.curve)));
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: motion.drive(Tween(begin: widget.offset, end: Offset.zero)),
        child: ScaleTransition(
          scale: motion.drive(Tween(begin: widget.scaleFrom, end: 1)),
          child: widget.child,
        ),
      ),
    );
  }
}
