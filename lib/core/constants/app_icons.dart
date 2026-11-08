/// Paths of the SVG icons bundled under `assets/icons/`.
abstract final class AppIcons {
  /// Full-colour Google "G"; draw it without a tint.
  static const google = 'assets/icons/google_logo.svg';

  /// Single-colour Apple logo (`currentColor`); tint it to match the text.
  static const apple = 'assets/icons/apple_logo.svg';

  /// Full-colour Facebook "f"; draw it without a tint.
  static const facebook = 'assets/icons/facebook_logo.svg';

  /// TikTok note: fixed cyan / red offsets around a `currentColor` body, so pass
  /// `currentColor` (not `color`) to keep it visible in light and dark mode.
  static const tiktok = 'assets/icons/tiktok_logo.svg';

  // Bottom navigation (stroke icons in `currentColor`).
  static const navHome = 'assets/icons/nav_home.svg';
  static const navRewards = 'assets/icons/nav_rewards.svg';
  static const navMenu = 'assets/icons/nav_menu.svg';
  static const navWallet = 'assets/icons/nav_wallet.svg';
  static const navSettings = 'assets/icons/nav_settings.svg';
}
