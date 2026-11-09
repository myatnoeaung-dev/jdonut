import 'package:flutter/material.dart';

import '../theme/app_dimens.dart';

/// Centered pill tabs for the nearest [DefaultTabController]: the selected tab
/// is a cyan pill with white text, the others are white pills.
class PillTabBar extends StatelessWidget {
  const PillTabBar({super.key, required this.labels});

  final List<String> labels;

  static Key tabKey(int index) => ValueKey('pillTab_$index');

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final (index, label) in labels.indexed)
            Flexible(
              child: _PillTab(
                key: tabKey(index),
                label: label,
                isSelected: controller.index == index,
                onTap: () => controller.animateTo(index),
              ),
            ),
        ],
      ),
    );
  }
}

class _PillTab extends StatelessWidget {
  const _PillTab({super.key, required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const Duration _colorChange = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(fontWeight: FontWeight.w600, color: isSelected ? colors.onPrimary : colors.onSurface);
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // The outer padding keeps the tap target at least 48 tall.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.sm),
          child: AnimatedContainer(
            duration: _colorChange,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary : colors.surface,
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
            child: Text(label, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
