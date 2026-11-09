import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Brand colours that Material's [ColorScheme] has no slot for.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.backgroundTop,
    required this.backgroundBottom,
    required this.pageBackground,
    required this.headerBackground,
    required this.link,
    required this.progress,
    required this.progressTrack,
    required this.mutedText,
    required this.badge,
    required this.onBadge,
    required this.help,
    required this.tierIcon,
    required this.tierBadgeFill,
    required this.badgeLight,
    required this.shadow,
    required this.decorative,
    required this.banners,
    required this.tierBronze,
    required this.tierSilver,
    required this.tierGold,
    required this.tierPlatinum,
    required this.tierLine,
    required this.disabledFill,
    required this.sprinkles,
  });

  static const AppPalette light = AppPalette(
    backgroundTop: AppColors.blushTop,
    backgroundBottom: AppColors.blushBottom,
    pageBackground: AppColors.pageGray,
    headerBackground: AppColors.headerPeach,
    link: AppColors.pink,
    progress: AppColors.pink,
    progressTrack: AppColors.skyLight,
    mutedText: AppColors.muted,
    badge: AppColors.orange,
    onBadge: AppColors.white,
    help: AppColors.green,
    tierIcon: AppColors.tierStar,
    tierBadgeFill: AppColors.tierBadgeFill,
    badgeLight: AppColors.orangeLight,
    shadow: AppColors.shadow,
    decorative: [AppColors.peach, AppColors.lavender, AppColors.butter, AppColors.aqua, AppColors.rose],
    banners: [AppColors.purple, AppColors.sky, AppColors.pink],
    tierBronze: AppColors.tierBronze,
    tierSilver: AppColors.tierSilver,
    tierGold: AppColors.tierGold,
    tierPlatinum: AppColors.tierPlatinum,
    tierLine: AppColors.inkSoft,
    disabledFill: AppColors.disabledFill,
    sprinkles: [AppColors.white, AppColors.rose],
  );

  final Color backgroundTop;
  final Color backgroundBottom;

  /// Light grey behind Home and Product detail.
  final Color pageBackground;

  /// Peach band behind the member header on Home.
  final Color headerBackground;
  final Color link;
  final Color progress;
  final Color progressTrack;
  final Color mutedText;

  /// Orange pills: "30% off", "New", notification count.
  final Color badge;
  final Color onBadge;

  /// Green "What's this?" icon on Product detail.
  final Color help;

  /// Grey star showing the member tier on Home.
  final Color tierIcon;

  /// Fill of the hexagon tier badge behind the Home header.
  final Color tierBadgeFill;

  /// Light end of orange gradients (avatar ring, badge edge).
  final Color badgeLight;
  final Color shadow;

  /// Soft circle/tile colours placed behind donut artwork.
  final List<Color> decorative;

  /// Promo banner card colours on Home.
  final List<Color> banners;

  // Member tier badges on Rewards.
  final Color tierBronze;
  final Color tierSilver;
  final Color tierGold;
  final Color tierPlatinum;

  /// The reached part of the line joining tier badges.
  final Color tierLine;

  /// Disabled pill buttons (EARN before a challenge is done).
  final Color disabledFill;

  /// Sprinkles drawn on the pink points ring.
  final List<Color> sprinkles;

  Color decorativeAt(int index) => decorative[index % decorative.length];

  Color bannerAt(int index) => banners[index % banners.length];

  @override
  AppPalette copyWith({Color? link}) => AppPalette(
    backgroundTop: backgroundTop,
    backgroundBottom: backgroundBottom,
    pageBackground: pageBackground,
    headerBackground: headerBackground,
    link: link ?? this.link,
    progress: progress,
    progressTrack: progressTrack,
    mutedText: mutedText,
    badge: badge,
    onBadge: onBadge,
    help: help,
    tierIcon: tierIcon,
    tierBadgeFill: tierBadgeFill,
    badgeLight: badgeLight,
    shadow: shadow,
    decorative: decorative,
    banners: banners,
    tierBronze: tierBronze,
    tierSilver: tierSilver,
    tierGold: tierGold,
    tierPlatinum: tierPlatinum,
    tierLine: tierLine,
    disabledFill: disabledFill,
    sprinkles: sprinkles,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) => other ?? this;
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
