import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_palette.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static const double _navIndicatorAlpha = 0.18;
  static const double _focusedBorderWidth = 1.5;

  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.sky,
      onPrimary: AppColors.white,
      secondary: AppColors.pink,
      onSecondary: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.muted,
      error: AppColors.error,
    );
    final textTheme = AppTypography.textTheme(ink: AppColors.ink, body: AppColors.inkSoft);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.blushBottom,
      extensions: const [AppPalette.light],
      inputDecorationTheme: _inputTheme(colorScheme, textTheme),
      filledButtonTheme: _filledButtonTheme(colorScheme, textTheme),
      navigationBarTheme: _navigationBarTheme(colorScheme),
    );
  }

  static InputDecorationTheme _inputTheme(ColorScheme colors, TextTheme textTheme) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadii.xs), borderSide: BorderSide.none);
    // The decorator animates between these, so focus and errors fade in.
    OutlineInputBorder outlined(Color color) => border.copyWith(
      borderSide: BorderSide(color: color, width: _focusedBorderWidth),
    );
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      hintStyle: textTheme.bodyLarge?.copyWith(color: AppColors.muted),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
      border: border,
      enabledBorder: border,
      focusedBorder: outlined(colors.primary),
      errorBorder: outlined(colors.error),
      focusedErrorBorder: outlined(colors.error),
    );
  }

  static FilledButtonThemeData _filledButtonTheme(ColorScheme colors, TextTheme textTheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
        shape: const StadiumBorder(),
        textStyle: textTheme.labelLarge,
      ),
    );
  }

  static NavigationBarThemeData _navigationBarTheme(ColorScheme colors) {
    return NavigationBarThemeData(
      backgroundColor: colors.surface,
      indicatorColor: colors.primary.withValues(alpha: _navIndicatorAlpha),
    );
  }
}
