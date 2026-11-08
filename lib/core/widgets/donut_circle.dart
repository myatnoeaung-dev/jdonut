import 'package:flutter/material.dart';

/// A soft coloured circle with donut artwork in it. Always square.
///
/// Uses the bundled image at [imagePath] and falls back to a donut icon until
/// the artwork is added to `assets/images/`.
class DonutCircle extends StatelessWidget {
  const DonutCircle({super.key, required this.backgroundColor, this.imagePath, this.semanticLabel});

  final Color backgroundColor;
  final String? imagePath;
  final String? semanticLabel;

  static const double _artworkFactor = 0.76;
  static const double _iconAlpha = 0.7;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: _artworkFactor,
            heightFactor: _artworkFactor,
            child: _artwork(context),
          ),
        ),
      ),
    );
  }

  Widget _artwork(BuildContext context) {
    final fallback = FittedBox(
      child: Icon(
        Icons.donut_large_rounded,
        color: Theme.of(context).colorScheme.surface.withValues(alpha: _iconAlpha),
        semanticLabel: semanticLabel,
      ),
    );
    final path = imagePath;
    if (path == null) return fallback;
    return Image.asset(
      path,
      fit: BoxFit.contain,
      semanticLabel: semanticLabel,
      errorBuilder: (_, _, _) => fallback,
    );
  }
}
