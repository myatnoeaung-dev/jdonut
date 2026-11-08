import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Brand colours that Material's [ColorScheme] has no slot for.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.backgroundTop,
    required this.backgroundBottom,
    required this.link,
    required this.progress,
    required this.progressTrack,
    required this.mutedText,
    required this.shadow,
    required this.decorative,
  });

  static const AppPalette light = AppPalette(
    backgroundTop: AppColors.blushTop,
    backgroundBottom: AppColors.blushBottom,
    link: AppColors.pink,
    progress: AppColors.pink,
    progressTrack: AppColors.skyLight,
    mutedText: AppColors.muted,
    shadow: AppColors.shadow,
    decorative: [AppColors.peach, AppColors.lavender, AppColors.butter, AppColors.aqua, AppColors.rose],
  );

  final Color backgroundTop;
  final Color backgroundBottom;
  final Color link;
  final Color progress;
  final Color progressTrack;
  final Color mutedText;
  final Color shadow;

  /// Soft circle colours placed behind donut artwork.
  final List<Color> decorative;

  Color decorativeAt(int index) => decorative[index % decorative.length];

  @override
  AppPalette copyWith({Color? link}) => AppPalette(
        backgroundTop: backgroundTop,
        backgroundBottom: backgroundBottom,
        link: link ?? this.link,
        progress: progress,
        progressTrack: progressTrack,
        mutedText: mutedText,
        shadow: shadow,
        decorative: decorative,
      );

  @override
  AppPalette lerp(AppPalette? other, double t) => other ?? this;
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
