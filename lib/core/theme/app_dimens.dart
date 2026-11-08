abstract final class AppRadii {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 18;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 28;
  static const double pill = 999;
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  /// Standard screen horizontal padding.
  static const double screenH = 28;

  /// Horizontal padding on Home (a little tighter so cards get more room).
  static const double homeH = 24;
}

/// Fixed component sizes from the design.
abstract final class AppSizes {
  static const double buttonHeight = 52;
  static const double buttonSpinner = 22;
  static const double inlineSpinner = 20;
  static const double fieldHeight = 60;
  static const double backButton = 36;
  static const double backIcon = 20;
  static const double progressRing = 30;
  static const double progressStroke = 6;
  static const double progressCheckIcon = 16;
  static const double otpBoxWidth = 40;
  static const double otpBoxHeight = 52;
  static const double socialIcon = 24;
  static const double socialTapTarget = 48;
  static const double contentMaxWidth = 440;
  static const double navIcon = 26;
  static const double navItem = 48;
  static const double navItemMin = 44;
  static const double navLabelMaxWidth = 84;

  // Home
  static const double avatar = 50;
  static const double avatarRingGap = 2;
  static const double avatarRingStroke = 4;
  static const double notificationButton = 36;
  static const double notificationCount = 24;
  static const double homePanelRadius = 32;
  static const double tierHexagon = 160;
  static const double tierStar = 44;
  static const double shopIconBadge = 30;
  static const double bannerPhotoBorder = 3;
  static const double shopCardWidth = 240;
  static const double compactButtonHeight = 44;
  static const double chevronButton = 28;
  static const double chevronIcon = 18;
  static const double tierBadge = 64;
  static const double bannerHeight = 150;
  // Home cards scale with the screen width (measured on a 390-wide phone).
  static const double offerCardWidthFactor = 0.62;
  static const double offerCardMaxWidth = 280;
  static const double offerImageAspectRatio = 1.5;
  static const double productCardWidthFactor = 0.41;
  static const double productCardMaxWidth = 190;

  /// Tall white cards in Popular (width : height ≈ 2 : 3).
  static const double productTallAspectRatio = 0.66;

  /// Square white cards in Order again.
  static const double productSquareAspectRatio = 1;

  // Settings
  static const double settingsIconBox = 36;
  static const double settingsIcon = 20;
  static const double settingsTierIcon = 16;

  // Product detail
  static const double stepperButton = 30;
  static const double stepperIcon = 18;
  static const double helpIcon = 22;
}
