import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../extensions/l10n_extension.dart';

/// Bottom navigation around the Home and Rewards tabs.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTabSelected,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.card_giftcard_outlined),
            selectedIcon: const Icon(Icons.card_giftcard_rounded),
            label: l10n.navRewards,
          ),
        ],
      ),
    );
  }

  /// Tapping the current tab again returns it to its first page.
  void _onTabSelected(int index) =>
      navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
}
