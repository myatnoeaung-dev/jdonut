import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../product/domain/entities/product.dart';

/// Big 3:2 photo card with an optional discount badge (Seasonal specials).
/// About 62% of the screen width, so the next card peeks in.
class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.product, required this.onTap, this.colorIndex = 0});

  final Product product;
  final VoidCallback onTap;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    final width = math.min(
      MediaQuery.sizeOf(context).width * AppSizes.offerCardWidthFactor,
      AppSizes.offerCardMaxWidth,
    );
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(aspectRatio: AppSizes.offerImageAspectRatio, child: _photo(context)),
            const SizedBox(height: AppSpacing.md),
            Text(product.name, style: Theme.of(context).textTheme.titleSmall, maxLines: 2),
          ],
        ),
      ),
    );
  }

  Widget _photo(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppNetworkImage(
          path: product.imageUrl,
          borderRadius: BorderRadius.circular(AppRadii.md),
          placeholderColorIndex: colorIndex,
          backgroundColor: context.palette.decorativeAt(colorIndex),
          padding: const EdgeInsets.all(AppSpacing.md),
        ),
        if (product.hasDiscount)
          Positioned(
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: AppBadge(label: context.l10n.discountOff(product.discountPercent!), size: AppBadgeSize.large),
          ),
      ],
    );
  }
}
