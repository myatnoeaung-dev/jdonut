import 'package:flutter/widgets.dart';

import '../theme/app_motion.dart';

/// A number that rolls when it changes: the new value slides in from below
/// when it goes up and from above when it goes down, like an odometer.
class AnimatedCount extends StatefulWidget {
  const AnimatedCount({super.key, required this.value, this.style, this.format});

  final int value;
  final TextStyle? style;

  /// Turns the value into text; defaults to the plain number.
  final String Function(int value)? format;

  @override
  State<AnimatedCount> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends State<AnimatedCount> {
  /// How far (as a share of the text height) numbers travel in and out.
  static const double _travel = 0.7;

  /// Same-width digits, so neighbours don't shift while numbers roll.
  static const List<FontFeature> _tabularDigits = [FontFeature.tabularFigures()];

  bool _isIncreasing = true;

  @override
  void didUpdateWidget(AnimatedCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _isIncreasing = widget.value > oldWidget.value;
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.format?.call(widget.value) ?? '${widget.value}';
    return ClipRect(
      child: AnimatedSwitcher(
        duration: context.motion(AppDurations.short),
        switchInCurve: AppCurves.emphasized,
        switchOutCurve: AppCurves.emphasized,
        transitionBuilder: _transition,
        child: Text(
          text,
          key: ValueKey(widget.value),
          style: (widget.style ?? const TextStyle()).copyWith(fontFeatures: _tabularDigits),
        ),
      ),
    );
  }

  /// Incoming text rises into place; outgoing text (its animation runs in
  /// reverse) leaves the other way.
  Widget _transition(Widget child, Animation<double> animation) {
    final isIncoming = child.key == ValueKey(widget.value);
    final direction = _isIncreasing ? 1.0 : -1.0;
    final from = Offset(0, (isIncoming ? _travel : -_travel) * direction);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(Tween(begin: from, end: Offset.zero)),
        child: child,
      ),
    );
  }
}
