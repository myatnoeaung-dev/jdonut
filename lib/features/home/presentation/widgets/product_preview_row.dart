import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/donut_circle.dart';

/// Horizontal row of donut tiles. Tapping one calls [onProductTap] with its id.
class ProductPreviewRow extends StatelessWidget {
  const ProductPreviewRow({super.key, required this.productIds, required this.onProductTap});

  static const double tileSize = 110;

  static Key tileKey(String productId) => ValueKey('productTile_$productId');

  final List<String> productIds;
  final ValueChanged<String> onProductTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return SizedBox(
      height: tileSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productIds.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) => _tile(palette, productIds[index], index),
      ),
    );
  }

  Widget _tile(AppPalette palette, String productId, int index) {
    return SizedBox.square(
      dimension: tileSize,
      child: InkWell(
        key: tileKey(productId),
        customBorder: const CircleBorder(),
        onTap: () => onProductTap(productId),
        child: DonutCircle(backgroundColor: palette.decorativeAt(index), imagePath: AppImages.product(productId)),
      ),
    );
  }
}
