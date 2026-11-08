import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Bundled image with a soft placeholder when the asset is missing.
class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.borderRadius = BorderRadius.zero,
    this.placeholderColorIndex = 0,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.semanticLabel,
  });

  final String path;
  final BoxFit fit;
  final BorderRadius borderRadius;

  /// Which decorative palette colour the placeholder uses.
  final int placeholderColorIndex;

  /// Tile colour behind cut-out artwork; null for none.
  final Color? backgroundColor;
  final EdgeInsets padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final placeholder = _Placeholder(color: context.palette.decorativeAt(placeholderColorIndex));
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: backgroundColor ?? Colors.transparent,
        child: Padding(
          padding: padding,
          child: Image.asset(path, fit: fit, semanticLabel: semanticLabel, errorBuilder: (_, _, _) => placeholder),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.color});

  final Color color;

  static const double _iconFactor = 0.4;
  static const double _iconAlpha = 0.8;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: _iconFactor,
          heightFactor: _iconFactor,
          child: FittedBox(
            child: Icon(
              Icons.donut_large_rounded,
              color: Theme.of(context).colorScheme.surface.withValues(alpha: _iconAlpha),
            ),
          ),
        ),
      ),
    );
  }
}
