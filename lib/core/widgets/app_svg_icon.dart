import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

/// A square SVG icon from an asset path (e.g. `AuthAssets.google`).
///
/// Leave [color] null for multi-colour artwork such as brand logos; set it to
/// tint single-colour icons, e.g. to follow light / dark mode. [currentColor]
/// recolours only the artwork's `currentColor` parts and keeps its other colours.
class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon(this.asset, {super.key, this.size = 20, this.color, this.currentColor, this.semanticLabel});

  final String asset;
  final double size;
  final Color? color;
  final Color? currentColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      theme: currentColor == null ? const SvgTheme() : SvgTheme(currentColor: currentColor!),
      semanticsLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
    );
  }
}
