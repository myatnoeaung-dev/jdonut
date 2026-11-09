import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// A Home section as slivers: its title sticks to the top while the section's
/// row is on screen, then scrolls away with it.
class HomeSectionSliver extends StatelessWidget {
  const HomeSectionSliver({super.key, required this.title, required this.children, this.onSeeAll});

  final String title;
  final List<Widget> children;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        PinnedHeaderSliver(
          child: _SectionHeader(title: title, onSeeAll: onSeeAll),
        ),
        SliverToBoxAdapter(child: _CardRow(children: children)),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    // Opaque so cards scrolling underneath don't show through when pinned.
    return ColoredBox(
      color: context.palette.pageBackground,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.homeH, AppSpacing.xxl, AppSpacing.homeH, AppSpacing.lg),
        child: Row(
          children: [
            Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
            _SeeAllButton(onPressed: onSeeAll),
          ],
        ),
      ),
    );
  }
}

/// Horizontal cards. A Row sizes itself to the tallest card, so large text never clips.
class _CardRow extends StatelessWidget {
  const _CardRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // Bottom padding gives the generous gap between sections from the design.
      padding: const EdgeInsets.fromLTRB(AppSpacing.homeH, 0, AppSpacing.homeH, AppSpacing.lg),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: AppSpacing.lg, children: children),
    );
  }
}

class _SeeAllButton extends StatelessWidget {
  const _SeeAllButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed ?? () {},
      tooltip: context.l10n.seeAll,
      style: IconButton.styleFrom(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        minimumSize: const Size.square(AppSizes.chevronButton),
      ),
      icon: const Icon(Icons.chevron_right_rounded, size: AppSizes.chevronIcon),
    );
  }
}
