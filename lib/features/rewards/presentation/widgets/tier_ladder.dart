import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/widgets/member_tier_label.dart';
import '../../domain/entities/member.dart';

/// Vertical ladder of three tiers starting at the member's tier, e.g.
/// Silver (here now) → Gold (points to go) → Platinum (soon).
class TierLadder extends StatelessWidget {
  const TierLadder({super.key, required this.member});

  final Member member;

  static const int _visibleTierCount = 3;

  @override
  Widget build(BuildContext context) {
    final tiers = _visibleTiers(member.tier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, tier) in tiers.indexed) ...[
          if (index > 0) const _Connector(),
          _TierStep(tier: tier, subtitle: _subtitle(context.l10n, tier)),
        ],
      ],
    );
  }

  /// The member's tier and the ones after it; near the top, the last three.
  static List<MemberTier> _visibleTiers(MemberTier current) {
    const tiers = MemberTier.values;
    final start = math.min(current.index, tiers.length - _visibleTierCount);
    return tiers.sublist(start, start + _visibleTierCount);
  }

  String _subtitle(AppLocalizations l10n, MemberTier tier) => switch (tier.index.compareTo(member.tier.index)) {
    < 0 => l10n.tierUnlocked,
    0 => l10n.tierCurrent,
    _ when tier == member.nextTier => l10n.tierPointsRemaining(member.pointsToNextTier, memberTierName(l10n, tier)),
    _ => l10n.tierUpcoming,
  };
}

class _TierStep extends StatelessWidget {
  const _TierStep({required this.tier, required this.subtitle});

  final MemberTier tier;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final name = memberTierName(context.l10n, tier);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TierBadge(tier: tier, name: name),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(subtitle, style: textTheme.bodySmall?.copyWith(color: context.palette.mutedText)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Round badge in the tier's colour with the tier's first letter.
class _TierBadge extends StatelessWidget {
  const _TierBadge({required this.tier, required this.name});

  final MemberTier tier;
  final String name;

  static const double _outlineWidth = 2;

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return ExcludeSemantics(
      child: Container(
        width: AppSizes.tierLadderBadge,
        height: AppSizes.tierLadderBadge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _tierColor(context.palette),
          shape: BoxShape.circle,
          border: Border.all(color: surface, width: _outlineWidth),
          boxShadow: [BoxShadow(color: context.palette.shadow, blurRadius: AppSpacing.xs)],
        ),
        child: Text(
          name.characters.first.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: surface),
          textScaler: TextScaler.noScaling, // the badge is a fixed-size icon
        ),
      ),
    );
  }

  Color _tierColor(AppPalette palette) => switch (tier) {
    MemberTier.bronze => palette.tierBronze,
    MemberTier.silver => palette.tierSilver,
    MemberTier.gold => palette.tierGold,
    MemberTier.platinum => palette.tierPlatinum,
  };
}

/// Thin grey line joining two badges.
class _Connector extends StatelessWidget {
  const _Connector();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: (AppSizes.tierLadderBadge - AppSizes.tierLadderLine) / 2),
      child: SizedBox(
        width: AppSizes.tierLadderLine,
        height: AppSizes.tierLadderConnector,
        child: ColoredBox(color: context.palette.disabledFill),
      ),
    );
  }
}
