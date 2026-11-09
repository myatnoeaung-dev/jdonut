import 'package:flutter/widgets.dart';

import '../theme/app_motion.dart';

/// Shrinks [child] slightly while a finger is down on it, as press feedback.
/// Doesn't handle taps itself: wrap a button or an InkWell.
class PressScale extends StatefulWidget {
  const PressScale({super.key, required this.child, this.enabled = true, this.pressedScale = defaultPressedScale});

  static const double defaultPressedScale = 0.95;

  final Widget child;

  /// False for disabled buttons: no feedback.
  final bool enabled;
  final double pressedScale;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _isPressed = false;

  void _setPressed(bool isPressed) {
    if (_isPressed == isPressed || (isPressed && !widget.enabled)) return;
    setState(() => _isPressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1,
        duration: context.motion(AppDurations.press),
        curve: AppCurves.emphasized,
        child: widget.child,
      ),
    );
  }
}
