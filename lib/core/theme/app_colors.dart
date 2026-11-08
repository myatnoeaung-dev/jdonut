import 'package:flutter/painting.dart';

/// Raw J'Donuts palette taken from the design. Only the theme reads these —
/// widgets get colours from `Theme.of(context)` or `context.palette`.
abstract final class AppColors {
  // Brand
  static const Color sky = Color(0xFF5CCFEA);
  static const Color skyLight = Color(0xFFADDFF3);
  static const Color pink = Color(0xFFF2589C);

  // Backgrounds
  static const Color blushTop = Color(0xFFFDE5ED);
  static const Color blushBottom = Color(0xFFFFF7F9);
  static const Color white = Color(0xFFFFFFFF);

  // Text
  static const Color ink = Color(0xFF26262E);
  static const Color inkSoft = Color(0xFF4B4B57);
  static const Color muted = Color(0xFF9B9BA6);

  // Status
  static const Color error = Color(0xFFD93A4A);

  // Decorative circles behind donut artwork
  static const Color peach = Color(0xFFF9D9C4);
  static const Color lavender = Color(0xFFBFD3F2);
  static const Color butter = Color(0xFFFCE3B0);
  static const Color aqua = Color(0xFF3FD9EE);
  static const Color rose = Color(0xFFF7C6D6);

  // Home & product
  static const Color pageGray = Color(0xFFF2F2F4);
  static const Color headerPeach = Color(0xFFFDE7D8);
  static const Color orange = Color(0xFFFF8A1F);
  static const Color green = Color(0xFF8BC34A);
  static const Color purple = Color(0xFF5B4FD9);
  static const Color tierStar = Color(0xFF8F8682);
  static const Color tierBadgeFill = Color(0xFFF6D6C0);
  static const Color orangeLight = Color(0xFFFFC08A);

  // Shadows
  static const Color shadow = Color(0x14000000);
}
