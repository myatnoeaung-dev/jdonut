import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/donut_circle.dart';

/// Banner at the top of Home (placeholder until banner artwork is provided).
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  static const double _aspectRatio = 2.2;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.xxl),
          gradient: LinearGradient(colors: [palette.link, palette.decorativeAt(4)]),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.seasonalSpecials,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: DonutCircle(backgroundColor: palette.decorativeAt(0), imagePath: AppImages.donutStrawberry),
            ),
          ],
        ),
      ),
    );
  }
}
