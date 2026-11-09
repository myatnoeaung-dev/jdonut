import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_motion.dart';
import '../theme/app_palette.dart';

/// Sweeps a soft highlight across [child]'s skeleton shapes while content
/// loads. Shapes are painted in any opaque colour; the shimmer recolours them.
class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.child});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  /// Where the highlight sits across the band (start, centre, end).
  static const List<double> _stops = [0.35, 0.5, 0.65];

  late final AnimationController _controller = AnimationController(vsync: this, duration: AppDurations.shimmerSweep);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // A still skeleton is enough when the user prefers less motion.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.palette.disabledFill;
    final highlight = Theme.of(context).colorScheme.surface;
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          colors: [base, highlight, base],
          stops: _stops,
          transform: _SlideGradient(_controller.value),
        ).createShader(bounds),
        child: child,
      ),
    );
  }
}

/// Moves the gradient from fully left of the box to fully right of it.
class _SlideGradient extends GradientTransform {
  const _SlideGradient(this.progress);

  final double progress;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * (progress * 2 - 1), 0, 0);
}

/// A rounded placeholder block inside a [Shimmer].
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.width, this.height, this.radius = AppRadii.md});

  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: context.palette.disabledFill, borderRadius: BorderRadius.circular(radius)),
    );
  }
}
