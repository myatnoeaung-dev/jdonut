import 'package:flutter/material.dart';

import '../../../../core/widgets/entrance_animation.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../domain/entities/product.dart';
import 'add_to_cart_bar.dart';
import 'product_description.dart';
import 'product_hero_card.dart';

/// Product card, description and the add-to-cart bar pinned at the bottom.
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
    required this.quantity,
    required this.totalMmk,
    required this.onQuantityChanged,
    required this.onAddToCart,
    this.heroTag,
  });

  final Product product;
  final int quantity;
  final int totalMmk;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;
  final String? heroTag;

  /// The bar rises from the bottom edge.
  static const Offset _barOffset = Offset(0, 0.6);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            // The card arrives with the hero image; the description follows.
            children: [
              ProductHeroCard(
                product: product,
                heroTag: heroTag,
                quantity: quantity,
                onQuantityChanged: onQuantityChanged,
              ),
              ...EntranceAnimation.staggered(delay: AppDurations.productDetailsDelay, [
                const SizedBox(height: AppSpacing.xxl),
                ProductDescription(description: product.description),
              ]),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg),
          child: EntranceAnimation(
            delay: AppDurations.productDetailsDelay,
            offset: _barOffset,
            child: AddToCartBar(totalMmk: totalMmk, onPressed: onAddToCart),
          ),
        ),
      ],
    );
  }
}
