import 'package:flutter/material.dart';

/// Type scale used across the app. Sizes come from the design; colours are
/// passed in by the theme so widgets never set them.
abstract final class AppTypography {
  static const double _displaySize = 30;
  static const double _headlineSize = 28;
  static const double _headlineSmallSize = 24;
  static const double _titleLargeSize = 21;
  static const double _titleSize = 18;
  static const double _titleSmallSize = 15;
  static const double _fieldSize = 17;
  static const double _bodySize = 14;
  static const double _captionSize = 12;
  static const double _buttonSize = 14;
  static const double _badgeSize = 11;

  static const double _tightHeight = 1.15;
  static const double _cardTitleHeight = 1.45;
  static const double _bodyHeight = 1.45;
  static const double _buttonLetterSpacing = 1.2;
  static const double _headingLetterSpacing = -0.3;

  static TextTheme textTheme({required Color ink, required Color body}) => TextTheme(
    displaySmall: _heading(_displaySize, ink),
    headlineMedium: _heading(_headlineSize, ink),
    headlineSmall: _heading(_headlineSmallSize, ink),
    titleLarge: _heading(_titleLargeSize, ink),
    titleMedium: TextStyle(fontSize: _titleSize, fontWeight: FontWeight.w700, color: ink),
    titleSmall: TextStyle(fontSize: _titleSmallSize, fontWeight: FontWeight.w700, height: _cardTitleHeight, color: ink),
    bodyLarge: TextStyle(fontSize: _fieldSize, color: ink),
    bodyMedium: TextStyle(fontSize: _bodySize, height: _bodyHeight, color: body),
    bodySmall: TextStyle(fontSize: _captionSize, height: _bodyHeight, color: body),
    labelLarge: const TextStyle(
      fontSize: _buttonSize,
      fontWeight: FontWeight.w800,
      letterSpacing: _buttonLetterSpacing,
    ),
    labelSmall: const TextStyle(fontSize: _badgeSize, fontWeight: FontWeight.w700),
  );

  static TextStyle _heading(double size, Color color) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w800,
    height: _tightHeight,
    letterSpacing: _headingLetterSpacing,
    color: color,
  );
}
