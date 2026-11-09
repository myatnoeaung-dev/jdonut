import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/price_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/widgets/press_scale.dart';

/// "ADD TO CART | 3,200 MMK" pill at the bottom of Product detail.
class AddToCartBar extends StatelessWidget {
  const AddToCartBar({super.key, required this.totalMmk, required this.onPressed});

  final int totalMmk;
  final VoidCallback onPressed;

  static const double _dividerHeight = 18;
  static const double _dividerAlpha = 0.6;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return PressScale(
      child: FilledButton(
        onPressed: onPressed,
        // Shrinks the label instead of overflowing on small phones with large text.
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.addToCart.toUpperCase(), locale: locale),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SizedBox(
                  height: _dividerHeight,
                  child: VerticalDivider(color: onPrimary.withValues(alpha: _dividerAlpha), width: 1),
                ),
              ),
              // Rolls to the new total when the quantity changes.
              TweenAnimationBuilder<double>(
                tween: Tween(end: totalMmk.toDouble()),
                duration: context.motion(AppDurations.short),
                curve: AppCurves.emphasized,
                builder: (context, total, _) => Text(context.formatMmk(total.round())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
