import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/price_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/hero_wrap.dart';
import '../../domain/entities/product.dart';
import 'quantity_stepper.dart';

/// White card with code, New badge, name, price and photo. The quantity
/// stepper sits across its bottom edge.
class ProductHeroCard extends StatelessWidget {
  const ProductHeroCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    this.heroTag,
  });

  final Product product;

  /// Tag shared with the Home image the photo flies from.
  final String? heroTag;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  /// How far the stepper hangs below the card.
  static const double _stepperOverhang = 22;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: _stepperOverhang),
          child: _CardBody(product: product, heroTag: heroTag),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: QuantityStepper(quantity: quantity, onChanged: onQuantityChanged),
          ),
        ),
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({required this.product, this.heroTag});

  final Product product;
  final String? heroTag;

  static const double _imageAspectRatio = 1.3;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.huge),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(product.code, style: textTheme.bodySmall?.copyWith(color: context.palette.mutedText)),
              ),
              if (product.isNew) AppBadge(label: context.l10n.productNew),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(product.name, style: textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(context.formatMmk(product.finalPriceMmk), style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.lg),
          AspectRatio(
            aspectRatio: _imageAspectRatio,
            child: heroWrap(heroTag, AppNetworkImage(path: product.imageUrl, semanticLabel: product.name)),
          ),
        ],
      ),
    );
  }
}
