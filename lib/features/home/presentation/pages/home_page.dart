import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/status_bar_strip.dart';
import '../../../product/domain/entities/product.dart';
import '../sample/home_sample_content.dart';
import '../widgets/home_header_panel.dart';
import '../widgets/home_section.dart';
import '../widgets/nearby_shops_banner.dart';
import '../widgets/offer_card.dart';
import '../widgets/product_tile_card.dart';

/// Home tab. Content comes from [HomeSampleContent] until the home bloc exists.
///
/// Scrolling: the header panel scrolls away, each section title sticks to the
/// top while its row is visible, and a peach strip stays behind the status bar.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Key of a product card, for tests.
  static Key productCardKey(String productId) => ValueKey('homeProduct_$productId');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void openProduct(Product product) => context.push(AppRoutes.productDetail(product.id));
    ProductTileCard Function(Product, int) tiles(double aspectRatio) =>
        (product, index) => ProductTileCard(
          product: product,
          colorIndex: index,
          aspectRatio: aspectRatio,
          onTap: () => openProduct(product),
        );

    return ColoredBox(
      color: context.palette.pageBackground,
      child: CustomScrollView(
        slivers: [
          const StatusBarStrip(),
          const SliverToBoxAdapter(
            child: HomeHeaderPanel(member: HomeSampleContent.member, banners: HomeSampleContent.banners),
          ),
          HomeSection(
            title: l10n.seasonalSpecials,
            children: _cards(HomeSampleContent.seasonalSpecials, (product, index) {
              return OfferCard(product: product, colorIndex: index, onTap: () => openProduct(product));
            }),
          ),
          HomeSection(
            title: l10n.popular,
            children: _cards(HomeSampleContent.popular, tiles(AppSizes.productTallAspectRatio)),
          ),
          HomeSection(
            title: l10n.orderAgain,
            children: _cards(HomeSampleContent.orderAgain, tiles(AppSizes.productSquareAspectRatio)),
          ),
          // Full width, touching the bottom: the background fills the end of the page.
          const SliverPadding(
            padding: EdgeInsets.only(top: AppSpacing.xxl),
            sliver: SliverToBoxAdapter(child: NearbyShopsBanner(shops: HomeSampleContent.nearbyShops)),
          ),
        ],
      ),
    );
  }

  List<Widget> _cards(List<Product> products, Widget Function(Product product, int index) buildCard) => [
    for (var index = 0; index < products.length; index++)
      KeyedSubtree(key: productCardKey(products[index].id), child: buildCard(products[index], index)),
  ];
}
