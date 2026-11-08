import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_badge.dart';
import '../sample/home_sample_content.dart';
import 'confetti_painter.dart';

/// Horizontally scrolling promo cards; the next card peeks in from the right.
/// Cards have no bottom padding: the Home header panel clips their lower edge.
class HomeBannerCarousel extends StatelessWidget {
  const HomeBannerCarousel({super.key, required this.banners});

  final List<HomeBanner> banners;

  static const double _cardWidthFactor = 0.76;
  static const double _visibleHeight = 170;

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width * _cardWidthFactor;
    return SizedBox(
      // Grow with large text so the title never overflows the card.
      height: MediaQuery.textScalerOf(context).scale(_visibleHeight),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.homeH),
        itemCount: banners.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) => SizedBox(
          width: cardWidth,
          child: _BannerCard(banner: banners[index], color: context.palette.bannerAt(index)),
        ),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner, required this.color});

  final HomeBanner banner;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final onBanner = Theme.of(context).colorScheme.surface;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xxl)),
      child: CustomPaint(
        painter: ConfettiPainter(background: color, dash: onBanner),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
          child: Column(
            children: [
              AppBadge(label: banner.tag, outlined: true, size: AppBadgeSize.large),
              const SizedBox(height: AppSpacing.sm),
              Text(
                banner.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: onBanner, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(child: _BannerPhoto(banner: banner)),
            ],
          ),
        ),
      ),
    );
  }
}

/// White-framed photo; new-shop banners get a shop badge on its top edge.
class _BannerPhoto extends StatelessWidget {
  const _BannerPhoto({required this.banner});

  final HomeBanner banner;

  static const double _photoWidthFactor = 0.8;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        FractionallySizedBox(
          widthFactor: _photoWidthFactor,
          child: Container(
            margin: const EdgeInsets.only(top: AppSizes.shopIconBadge / 2),
            decoration: BoxDecoration(
              border: Border.all(color: colors.surface, width: AppSizes.bannerPhotoBorder),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.lg)),
            ),
            child: AppAssetImage(
              path: banner.imagePath,
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.md)),
            ),
          ),
        ),
        if (banner.showsShopIcon) const _ShopIconBadge(),
      ],
    );
  }
}

class _ShopIconBadge extends StatelessWidget {
  const _ShopIconBadge();

  static const double _iconFactor = 0.6;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: AppSizes.shopIconBadge,
      height: AppSizes.shopIconBadge,
      decoration: BoxDecoration(color: colors.surface, shape: BoxShape.circle),
      child: Icon(Icons.storefront_rounded, size: AppSizes.shopIconBadge * _iconFactor, color: colors.secondary),
    );
  }
}
