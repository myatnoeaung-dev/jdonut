import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/coming_soon_view.dart';
import '../../../../core/widgets/donut_circle.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../widgets/quantity_stepper.dart';

/// `/product/:id`. Name, code and price arrive with the product bloc.
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  static const double _imageWidthFactor = 0.7;

  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.screenH),
            children: [
              const Align(alignment: Alignment.centerLeft, child: AppBackButton()),
              const SizedBox(height: AppSpacing.xxl),
              _image(),
              const SizedBox(height: AppSpacing.xxl),
              Text(l10n.productTitle, style: Theme.of(context).textTheme.headlineMedium),
              const ComingSoonView(),
              Center(child: QuantityStepper(quantity: _quantity, onChanged: (value) => setState(() => _quantity = value))),
              const SizedBox(height: AppSpacing.xxl),
              AppPrimaryButton(label: l10n.addToCart, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return FractionallySizedBox(
      widthFactor: _imageWidthFactor,
      child: AspectRatio(
        aspectRatio: 1,
        child: DonutCircle(
          backgroundColor: context.palette.decorativeAt(0),
          imagePath: AppImages.product(widget.productId),
        ),
      ),
    );
  }
}
