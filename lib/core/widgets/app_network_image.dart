import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../network/app_image_cache.dart';
import '../theme/app_palette.dart';

const String _assetPrefix = 'assets/';

/// Image provider for an `assets/...` path or a URL cached on disk (e.g. avatars).
ImageProvider appImageProvider(String path) => path.startsWith(_assetPrefix)
    ? AssetImage(path)
    : CachedNetworkImageProvider(path, cacheManager: AppImageCache.manager);

/// Shows a bundled asset (seed data) or a network image cached on disk, with
/// a soft placeholder while loading and when the image can't be shown.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.borderRadius = BorderRadius.zero,
    this.placeholderColorIndex = 0,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.semanticLabel,
  });

  /// `assets/...` path or an `http(s)` URL.
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
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: backgroundColor ?? Colors.transparent,
        child: Padding(padding: padding, child: _image(context)),
      ),
    );
  }

  Widget _image(BuildContext context) {
    final placeholderColor = context.palette.decorativeAt(placeholderColorIndex);
    if (path.startsWith(_assetPrefix)) {
      return Image.asset(
        path,
        fit: fit,
        semanticLabel: semanticLabel,
        errorBuilder: (_, _, _) => _Placeholder(color: placeholderColor, icon: Icons.donut_large_rounded),
      );
    }
    return Semantics(
      image: true,
      label: semanticLabel,
      child: CachedNetworkImage(
        imageUrl: path,
        cacheManager: AppImageCache.manager,
        fit: fit,
        placeholder: (_, _) => _Placeholder(color: placeholderColor, icon: Icons.donut_large_rounded),
        errorWidget: (_, _, _) => _Placeholder(color: placeholderColor, icon: Icons.broken_image_outlined),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.color, required this.icon});

  final Color color;
  final IconData icon;

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
            child: Icon(icon, color: Theme.of(context).colorScheme.surface.withValues(alpha: _iconAlpha)),
          ),
        ),
      ),
    );
  }
}
