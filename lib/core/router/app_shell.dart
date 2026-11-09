import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../constants/app_icons.dart';
import '../extensions/l10n_extension.dart';
import '../theme/app_palette.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/offline_banner.dart';

/// Bottom navigation around the five main tabs. Order matches the shell
/// branches in `app_router.dart`: Home, Rewards, Menu, Wallet, Settings.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      // Shows behind the bar's rounded corners; matches the tab pages.
      backgroundColor: context.palette.pageBackground,
      body: OfflineBannerOverlay(child: navigationShell),
      extendBody: true, // so the bar's rounded corners show the page behind
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: navigationShell.currentIndex,
        onSelected: _onTabSelected,
        destinations: [
          AppNavDestination(icon: AppIcons.navHome, label: l10n.navHome),
          AppNavDestination(icon: AppIcons.navRewards, label: l10n.navRewards),
          AppNavDestination(icon: AppIcons.navMenu, label: l10n.navMenu),
          AppNavDestination(icon: AppIcons.navWallet, label: l10n.navWallet),
          AppNavDestination(icon: AppIcons.navSettings, label: l10n.navSettings),
        ],
      ),
    );
  }

  /// Tapping the current tab again returns it to its first page.
  void _onTabSelected(int index) =>
      navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
}
