import 'package:flutter/material.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_asset_image.dart';
import '../sample/home_sample_content.dart';

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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xxl)),
      child: AppAssetImage(
              path: banner.imagePath,
              fit: BoxFit.cover,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.md)),
            ),
    );
  }
}
