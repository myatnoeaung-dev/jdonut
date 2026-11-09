import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/shimmer.dart';

/// Shimmering outline of Home (header, banner, two card rows) shown on the
/// first load, so the page doesn't jump when the content arrives.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  static const Key loadingKey = Key('homeSkeleton');

  static const double _nameWidth = 160;
  static const double _lineHeight = 18;
  static const double _titleWidth = 120;
  static const double _bannerHeight = 150;
  static const int _cardsPerRow = 3;
  static const int _rows = 2;

  @override
  Widget build(BuildContext context) {
    final cardWidth = math.min(
      MediaQuery.sizeOf(context).width * AppSizes.productCardWidthFactor,
      AppSizes.productCardMaxWidth,
    );
    return Semantics(
      key: loadingKey,
      label: context.l10n.loading,
      excludeSemantics: true,
      // The shimmer repaints every frame; keep that to the skeleton's own layer.
      child: RepaintBoundary(
        child: Shimmer(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              AppSpacing.homeH,
              MediaQuery.paddingOf(context).top + AppSpacing.xl,
              0,
              AppSpacing.xl,
            ),
            children: [
              const _Header(),
              const SizedBox(height: AppSpacing.xxl),
              const Padding(
                padding: EdgeInsets.only(right: AppSpacing.homeH),
                child: SkeletonBox(height: _bannerHeight, radius: AppRadii.xxl),
              ),
              for (var row = 0; row < _rows; row++) _CardRow(cardWidth: cardWidth),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SkeletonBox(width: AppSizes.avatar, height: AppSizes.avatar, radius: AppRadii.pill),
        SizedBox(width: AppSpacing.md),
        SkeletonBox(width: HomeSkeleton._nameWidth, height: HomeSkeleton._lineHeight),
      ],
    );
  }
}

/// A section title and a row of cards running off the right edge.
class _CardRow extends StatelessWidget {
  const _CardRow({required this.cardWidth});

  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xxl),
        const SkeletonBox(width: HomeSkeleton._titleWidth, height: HomeSkeleton._lineHeight),
        const SizedBox(height: AppSpacing.lg),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            spacing: AppSpacing.lg,
            children: [
              for (var card = 0; card < HomeSkeleton._cardsPerRow; card++)
                SkeletonBox(width: cardWidth, height: cardWidth / AppSizes.productTallAspectRatio, radius: AppRadii.lg),
            ],
          ),
        ),
      ],
    );
  }
}
