import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';
import 'app_svg_icon.dart';

class AppNavDestination {
  const AppNavDestination({required this.icon, required this.label});

  /// SVG asset path (stroke icon in `currentColor`).
  final String icon;
  final String label;
}

/// Cyan bar with rounded top corners and a white outline. The selected tab is
/// a pink pill with its label; the others show only a white icon.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.destinations, required this.selectedIndex, required this.onSelected});

  final List<AppNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const double _outlineWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xxxl)),
          border: Border.all(color: colors.surface, width: _outlineWidth),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [for (var index = 0; index < destinations.length; index++) _item(index)],
            ),
          ),
        ),
      ),
    );
  }

  /// The selected pill takes the room it needs first; on narrow screens the
  /// other tabs give up their spacing (never below a 44px tap target).
  Widget _item(int index) {
    final destination = destinations[index];
    if (index == selectedIndex) return _SelectedTab(destination: destination);
    return Flexible(
      child: _UnselectedTab(destination: destination, onTap: () => onSelected(index)),
    );
  }
}

class _SelectedTab extends StatelessWidget {
  const _SelectedTab({required this.destination});

  final AppNavDestination destination;

  static const double _outlineWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      selected: true,
      button: true,
      label: destination.label,
      excludeSemantics: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSizes.navItem),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(color: colors.surface, width: _outlineWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSvgIcon(destination.icon, size: AppSizes.navIcon, currentColor: colors.onSecondary),
            const SizedBox(width: AppSpacing.sm),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.navLabelMaxWidth),
              // Shrinks rather than overflowing for long labels with large text.
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  destination.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: colors.onSecondary),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnselectedTab extends StatelessWidget {
  const _UnselectedTab({required this.destination, required this.onTap});

  final AppNavDestination destination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onBar = Theme.of(context).colorScheme.onPrimary;
    return Semantics(
      button: true,
      label: destination.label,
      excludeSemantics: true,
      child: Tooltip(
        message: destination.label,
        child: InkResponse(
          onTap: onTap,
          radius: AppSizes.navItem / 2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: AppSizes.navItemMin,
              maxWidth: AppSizes.navItem,
              minHeight: AppSizes.navItem,
              maxHeight: AppSizes.navItem,
            ),
            child: Center(
              child: AppSvgIcon(destination.icon, size: AppSizes.navIcon, currentColor: onBar),
            ),
          ),
        ),
      ),
    );
  }
}
