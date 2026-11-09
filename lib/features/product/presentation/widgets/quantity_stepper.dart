import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/animated_count.dart';
import '../../../../core/widgets/press_scale.dart';

/// White pill with cyan – and + buttons around the quantity.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({super.key, required this.quantity, required this.onChanged, this.min = 1, this.max = 99});

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: theme.colorScheme.onSurfaceVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepButton(
              icon: Icons.remove_rounded,
              tooltip: l10n.decreaseQuantity,
              onPressed: quantity > min ? () => onChanged(quantity - 1) : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: AnimatedCount(value: quantity, style: theme.textTheme.titleMedium),
            ),
            _StepButton(
              icon: Icons.add_rounded,
              tooltip: l10n.increaseQuantity,
              onPressed: quantity < max ? () => onChanged(quantity + 1) : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.tooltip, required this.onPressed});

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return PressScale(
      enabled: onPressed != null,
      child: IconButton.filled(
        onPressed: onPressed,
        tooltip: tooltip,
        iconSize: AppSizes.stepperIcon,
        style: IconButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          minimumSize: const Size.square(AppSizes.stepperButton),
          fixedSize: const Size.square(AppSizes.stepperButton),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
        icon: Icon(icon),
      ),
    );
  }
}
