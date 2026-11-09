import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// "J' Donuts Rewards" title with the orange "Rewards [count]" pill touching
/// the right edge of the screen.
class RewardsHeader extends StatelessWidget {
  const RewardsHeader({super.key, required this.readyCount, required this.onRewardsTap});

  /// Rewards the member can claim now.
  final int readyCount;
  final VoidCallback onRewardsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AppSpacing.screenH, top: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.l10n.rewardsTitle,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          _ReadyRewardsPill(count: readyCount, onTap: onRewardsTap),
        ],
      ),
    );
  }
}

class _ReadyRewardsPill extends StatelessWidget {
  const _ReadyRewardsPill({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  static const BorderRadiusDirectional _startRounded = BorderRadiusDirectional.horizontal(
    start: Radius.circular(AppRadii.pill),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      button: true,
      label: l10n.rewardsReadyCount(count),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // The outer padding keeps the tap target at least 48 tall.
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: DecoratedBox(
            decoration: BoxDecoration(color: palette.badge, borderRadius: _startRounded),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(AppSpacing.lg, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.rewardsReady,
                    style: textTheme.bodyMedium?.copyWith(color: palette.onBadge, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _CountDot(count: count),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountDot extends StatelessWidget {
  const _CountDot({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      constraints: const BoxConstraints(minWidth: AppSizes.rewardsCount, minHeight: AppSizes.rewardsCount),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      decoration: BoxDecoration(color: palette.onBadge, borderRadius: BorderRadius.circular(AppRadii.pill)),
      child: Text('$count', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: palette.badge)),
    );
  }
}
