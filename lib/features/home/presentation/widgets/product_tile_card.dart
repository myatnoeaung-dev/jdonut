import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../product/domain/entities/product.dart';

/// White card with the product cut-out and its name underneath. About 41% of
/// the screen width; tall in Popular, square in Order again.
class ProductTileCard extends StatelessWidget {
  const ProductTileCard({
    super.key,
    required this.product,
    required this.onTap,
    this.colorIndex = 0,
    this.aspectRatio = AppSizes.productTallAspectRatio,
  });

  final Product product;
  final VoidCallback onTap;
  final int colorIndex;

  /// Width : height of the white card.
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final width = math.min(
      MediaQuery.sizeOf(context).width * AppSizes.productCardWidthFactor,
      AppSizes.productCardMaxWidth,
    );
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(aspectRatio: aspectRatio, child: _card(context)),
            const SizedBox(height: AppSpacing.md),
            Text(product.name, style: Theme.of(context).textTheme.titleSmall, maxLines: 2),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      // Small padding: the product fills most of the card, as in the design.
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppAssetImage(
              path: product.imageUrl,
              borderRadius: BorderRadius.circular(AppRadii.sm),
              placeholderColorIndex: colorIndex,
            ),
            if (product.hasDiscount)
              Positioned(
                right: 0,
                bottom: 0,
                child: AppBadge(label: context.l10n.discountOff(product.discountPercent!), size: AppBadgeSize.large),
              ),
          ],
        ),
      ),
    );
  }
}
