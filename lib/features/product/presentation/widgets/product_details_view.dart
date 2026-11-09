import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
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
  });

  final Product product;
  final int quantity;
  final int totalMmk;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            children: [
              ProductHeroCard(product: product, quantity: quantity, onQuantityChanged: onQuantityChanged),
              const SizedBox(height: AppSpacing.xxl),
              ProductDescription(description: product.description),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg),
          child: AddToCartBar(totalMmk: totalMmk, onPressed: onAddToCart),
        ),
      ],
    );
  }
}
