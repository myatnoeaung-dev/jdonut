import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/home_banner.dart';

/// Horizontally scrolling promo cards; the next card peeks in from the right.
/// Cards have no bottom padding: the Home header panel clips their lower edge.
///
/// Plays by itself, one card every few seconds, looping back to the first.
/// It pauses for a while after the user swipes, while Home is off screen, and
/// when the user prefers less motion.
class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.banners});

  final List<HomeBanner> banners;

  static const double _cardWidthFactor = 0.76;
  static const double _visibleHeight = 170;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;
  DateTime _lastSwipe = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(AppDurations.carouselInterval, (_) => _showNext());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  double get _stride => MediaQuery.sizeOf(context).width * HomeBannerCarousel._cardWidthFactor + AppSpacing.lg;

  void _showNext() {
    final isVisible = TickerMode.getValuesNotifier(context).value.enabled;
    final recentlySwiped = DateTime.now().difference(_lastSwipe) < AppDurations.carouselPauseAfterSwipe;
    if (!_controller.hasClients || !isVisible || recentlySwiped || context.reduceMotion) return;
    final position = _controller.position;
    final atEnd = position.pixels >= position.maxScrollExtent - 1;
    final next = atEnd ? 0.0 : ((position.pixels / _stride).round() + 1) * _stride;
    _controller.animateTo(
      next.clamp(0, position.maxScrollExtent),
      duration: AppDurations.carouselSlide,
      curve: AppCurves.standard,
    );
  }

  bool _onScroll(ScrollStartNotification notification) {
    if (notification.dragDetails != null) _lastSwipe = DateTime.now();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.sizeOf(context).width * HomeBannerCarousel._cardWidthFactor;
    final banners = widget.banners;
    return SizedBox(
      // Grow with large text so the title never overflows the card.
      height: MediaQuery.textScalerOf(context).scale(HomeBannerCarousel._visibleHeight),
      child: NotificationListener<ScrollStartNotification>(
        onNotification: _onScroll,
        child: ListView.separated(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.homeH),
          itemCount: banners.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
          itemBuilder: (context, index) => SizedBox(
            width: cardWidth,
            child: _BannerCard(banner: banners[index], color: context.palette.bannerAt(index)),
          ),
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
      child: AppNetworkImage(
        path: banner.imageUrl,
        fit: BoxFit.cover,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.md)),
        semanticLabel: banner.title,
      ),
    );
  }
}
