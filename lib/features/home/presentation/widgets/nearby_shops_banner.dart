import 'package:flutter/material.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../sample/home_sample_content.dart';
import 'shop_card.dart';

/// Full-width section at the bottom of Home: sky-and-grass background,
/// "There are 4 J'Donut shops near you", EXPLORE NOW and a row of shop cards.
class NearbyShopsBanner extends StatelessWidget {
  const NearbyShopsBanner({super.key, required this.shops, this.onExplore, this.onShopTap});

  final List<HomeShop> shops;
  final VoidCallback? onExplore;
  final ValueChanged<HomeShop>? onShopTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bottom-aligned so the grass always sits under the cards.
        Positioned.fill(
          child: Image.asset(
            AppImages.nearbyShopsBackground,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            excludeFromSemantics: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xxxl, bottom: AppSpacing.huge * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
                child: _Intro(shopCount: shops.length, onExplore: onExplore),
              ),
              const SizedBox(height: AppSpacing.xxl),
              _ShopRow(shops: shops, onShopTap: onShopTap),
            ],
          ),
        ),
      ],
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.shopCount, this.onExplore});

  final int shopCount;
  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.nearbyShopsCount(shopCount),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: colors.onPrimary),
        ),
        const SizedBox(height: AppSpacing.xl),
        FilledButton(
          onPressed: onExplore ?? () {},
          style: FilledButton.styleFrom(
            backgroundColor: colors.surface,
            foregroundColor: colors.primary,
            minimumSize: const Size(0, AppSizes.compactButtonHeight),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          ),
          child: Text(l10n.exploreNow.toUpperCase(), locale: Localizations.localeOf(context)),
        ),
      ],
    );
  }
}

/// Horizontal shop cards. A Row sizes itself to the tallest card, so large text never clips.
class _ShopRow extends StatelessWidget {
  const _ShopRow({required this.shops, this.onShopTap});

  final List<HomeShop> shops;
  final ValueChanged<HomeShop>? onShopTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.lg,
        children: [
          for (final shop in shops) ShopCard(shop: shop, onTap: onShopTap == null ? null : () => onShopTap!(shop)),
        ],
      ),
    );
  }
}
