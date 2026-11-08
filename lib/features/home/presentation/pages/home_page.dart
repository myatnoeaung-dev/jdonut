import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/coming_soon_view.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../widgets/home_section.dart';
import '../widgets/member_header.dart';
import '../widgets/product_preview_row.dart';
import '../widgets/promo_banner.dart';

/// Home layout. Product ids are temporary until the products come from the
/// local database through a bloc.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<String> _seasonalIds = ['p_coconut', 'p_matcha_cream', 'p_caramel_crunch'];
  static const List<String> _popularIds = ['p_chocolate_glazed', 'p_strawberry_sprinkle', 'p_classic_sugar'];
  static const List<String> _orderAgainIds = ['p_coconut', 'p_classic_sugar'];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void openProduct(String id) => context.push(AppRoutes.productDetail(id));

    return GradientBackground(
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screenH),
          children: [
            const MemberHeader(),
            const SizedBox(height: AppSpacing.xl),
            const PromoBanner(),
            HomeSection(
              title: l10n.seasonalSpecials,
              child: ProductPreviewRow(productIds: _seasonalIds, onProductTap: openProduct),
            ),
            HomeSection(
              title: l10n.popular,
              child: ProductPreviewRow(productIds: _popularIds, onProductTap: openProduct),
            ),
            HomeSection(
              title: l10n.orderAgain,
              child: ProductPreviewRow(productIds: _orderAgainIds, onProductTap: openProduct),
            ),
            HomeSection(title: l10n.nearbyShops, child: const ComingSoonView()),
          ],
        ),
      ),
    );
  }
}
