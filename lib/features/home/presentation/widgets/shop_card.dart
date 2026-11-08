import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_asset_image.dart';
import '../sample/home_sample_content.dart';

/// White card with the shop photo, name, address and an "Order Online" link.
class ShopCard extends StatelessWidget {
  const ShopCard({super.key, required this.shop, this.onTap, this.onOrderOnline});

  final HomeShop shop;
  final VoidCallback? onTap;
  final VoidCallback? onOrderOnline;

  static const double _photoAspectRatio = 1.6;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final palette = context.palette;
    return SizedBox(
      width: AppSizes.shopCardWidth,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(AppRadii.lg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: _photoAspectRatio,
                  child: AppAssetImage(
                    path: shop.imagePath,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                    semanticLabel: shop.name,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(shop.name, style: textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: AppSpacing.xs),
                Text(shop.address, style: textTheme.bodySmall?.copyWith(color: palette.mutedText), maxLines: 2),
                const SizedBox(height: AppSpacing.sm),
                InkWell(
                  onTap: onOrderOnline ?? () {},
                  child: Text(context.l10n.orderOnline, style: textTheme.titleSmall?.copyWith(color: palette.link)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
