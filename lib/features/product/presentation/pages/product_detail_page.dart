import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../domain/entities/product.dart';
import '../sample/sample_products.dart';
import '../widgets/add_to_cart_bar.dart';
import '../widgets/product_description.dart';
import '../widgets/product_hero_card.dart';

/// `/product/:id`. Reads [SampleProducts] until the product bloc exists.
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final Product? _product = SampleProducts.byId(widget.productId);
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = _product;
    return Scaffold(
      backgroundColor: context.palette.pageBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(onPressed: () => context.canPop() ? context.pop() : null),
            ),
            Expanded(child: product == null ? const _ProductNotFound() : _details(product)),
          ],
        ),
      ),
    );
  }

  Widget _details(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            children: [
              ProductHeroCard(
                product: product,
                quantity: _quantity,
                onQuantityChanged: (quantity) => setState(() => _quantity = quantity),
              ),
              const SizedBox(height: AppSpacing.xxl),
              ProductDescription(description: product.description),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg),
          child: AddToCartBar(totalMmk: product.finalPriceMmk * _quantity, onPressed: () {}),
        ),
      ],
    );
  }
}

class _ProductNotFound extends StatelessWidget {
  const _ProductNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Text(context.l10n.productNotFound, textAlign: TextAlign.center),
      ),
    );
  }
}
