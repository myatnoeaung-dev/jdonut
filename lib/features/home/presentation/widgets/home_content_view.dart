import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/widgets/entrance_animation.dart';
import '../../../../core/widgets/status_bar_strip.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../product/domain/entities/product.dart';
import '../../../rewards/presentation/bloc/member/member_bloc.dart';
import '../../domain/entities/home_banner.dart';
import '../../domain/entities/home_content.dart';
import 'home_header_panel.dart';
import 'home_section_sliver.dart';
import 'nearby_shops_banner.dart';
import 'offer_card.dart';
import 'product_tile_card.dart';

/// Home's scrolling content with pull-to-refresh.
///
/// Scrolling: the header panel scrolls away, each section title sticks to the
/// top while its row is visible, and a peach strip stays behind the status bar.
class HomeContentView extends StatelessWidget {
  const HomeContentView({super.key, required this.content, required this.onRefresh});

  final HomeContent content;
  final RefreshCallback onRefresh;

  static Key productCardKey(String productId) => ValueKey('homeProduct_$productId');

  static Duration _sectionDelay(int index) => AppDurations.homeSectionStep * (index + 1);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      edgeOffset: MediaQuery.paddingOf(context).top,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const StatusBarStrip(),
          SliverToBoxAdapter(
            child: EntranceAnimation(child: _HomeHeader(banners: content.banners)),
          ),
          for (final (index, section) in content.sections.indexed)
            _ProductSection(section: section, entranceDelay: _sectionDelay(index)),
          if (content.shops.isNotEmpty)
            // Full width, touching the bottom: the background fills the end of the page.
            SliverPadding(
              padding: const EdgeInsets.only(top: AppSpacing.xxl),
              sliver: SliverToBoxAdapter(
                child: EntranceAnimation(
                  delay: _sectionDelay(content.sections.length),
                  child: NearbyShopsBanner(shops: content.shops),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Member name from the session, tier and points from the shared member record.
class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.banners});

  final List<HomeBanner> banners;

  @override
  Widget build(BuildContext context) {
    final firstName = context.select<AuthBloc, String>(
      (bloc) => switch (bloc.state) {
        Authenticated(:final user) => user.firstName,
        _ => '',
      },
    );
    final member = context.select((MemberBloc bloc) => bloc.state.member);
    return HomeHeaderPanel(firstName: firstName, member: member, banners: banners);
  }
}

class _ProductSection extends StatelessWidget {
  const _ProductSection({required this.section, required this.entranceDelay});

  final HomeSection section;
  final Duration entranceDelay;

  /// Cards in a row slide in from the side, one after another.
  static const Offset _cardOffset = Offset(0.25, 0);

  @override
  Widget build(BuildContext context) {
    final products = section.products;
    return HomeSectionSliver(
      title: _titleOf(context.l10n, section.type),
      entranceDelay: entranceDelay,
      children: [
        for (final (index, product) in products.indexed)
          KeyedSubtree(
            key: HomeContentView.productCardKey(product.id),
            child: EntranceAnimation(
              delay: entranceDelay + AppDurations.staggerStep * index,
              offset: _cardOffset,
              child: _card(product, index, () => _open(context, product)),
            ),
          ),
      ],
    );
  }

  /// A product can appear in several sections, so the tag names the section too.
  String _heroTag(Product product) => 'product_${section.type.name}_${product.id}';

  void _open(BuildContext context, Product product) =>
      context.push(AppRoutes.productDetail(product.id, heroTag: _heroTag(product)));

  Widget _card(Product product, int index, VoidCallback onTap) => switch (section.type) {
    HomeSectionType.seasonal => OfferCard(
      product: product,
      colorIndex: index,
      heroTag: _heroTag(product),
      onTap: onTap,
    ),
    HomeSectionType.popular => ProductTileCard(
      product: product,
      colorIndex: index,
      aspectRatio: AppSizes.productTallAspectRatio,
      heroTag: _heroTag(product),
      onTap: onTap,
    ),
    HomeSectionType.orderAgain => ProductTileCard(
      product: product,
      colorIndex: index,
      aspectRatio: AppSizes.productSquareAspectRatio,
      heroTag: _heroTag(product),
      onTap: onTap,
    ),
  };

  static String _titleOf(AppLocalizations l10n, HomeSectionType type) => switch (type) {
    HomeSectionType.seasonal => l10n.seasonalSpecials,
    HomeSectionType.popular => l10n.popular,
    HomeSectionType.orderAgain => l10n.orderAgain,
  };
}
