import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import '../theme/app_palette.dart';

enum AppBadgeSize {
  /// "New" on Product detail.
  small,

  /// "30% off" on photo cards and tags on banners.
  large,
}

/// Orange pill: "30% off", "New", "New shop".
class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.label, this.outlined = false, this.size = AppBadgeSize.small});

  final String label;

  /// Adds a white outline, for badges sitting on coloured banners.
  final bool outlined;
  final AppBadgeSize size;

  static const double _outlineWidth = 1.5;
  static const double _lineHeight = 1.2;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final textTheme = Theme.of(context).textTheme;
    final isLarge = size == AppBadgeSize.large;
    final style = isLarge ? textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) : textTheme.labelSmall;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.badge,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: outlined ? Border.all(color: palette.onBadge, width: _outlineWidth) : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isLarge ? AppSpacing.md : AppSpacing.sm, vertical: AppSpacing.xs),
        child: Text(
          label,
          style: style?.copyWith(color: palette.onBadge, height: _lineHeight),
          maxLines: 1,
        ),
      ),
    );
  }
}
