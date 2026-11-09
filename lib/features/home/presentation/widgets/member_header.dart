import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/ringed_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../rewards/domain/entities/member.dart';
import 'member_tier_label.dart';

/// Ringed avatar, name, tier and the points-to-next-tier pill.
class MemberHeader extends StatelessWidget {
  const MemberHeader({super.key, required this.firstName, required this.member, this.nameRowEndSpace = 0});

  final String firstName;

  /// Null until the loyalty record loads: only the name shows.
  final Member? member;

  /// Room kept free at the end of the name row (for the bell tab).
  final double nameRowEndSpace;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final loyalty = member;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RingedAvatar(imagePath: loyalty?.avatarUrl, initial: _initialOf(firstName)),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstName, style: textTheme.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (loyalty != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(l10n.memberTier(memberTierName(l10n, loyalty.tier)), style: textTheme.bodyMedium),
                  ],
                ],
              ),
            ),
            SizedBox(width: nameRowEndSpace),
          ],
        ),
        if (loyalty != null) ...[
          const SizedBox(height: AppSpacing.md),
          _PointsPill(text: _nextTierText(l10n, loyalty)),
        ],
      ],
    );
  }

  static String _initialOf(String name) => name.isEmpty ? '' : name.characters.first.toUpperCase();

  static String _nextTierText(AppLocalizations l10n, Member member) {
    final nextTier = member.nextTier;
    if (nextTier == null) return l10n.topTierReached;
    return l10n.pointsToNextTier(member.pointsToNextTier, memberTierName(l10n, nextTier));
  }
}

class _PointsPill extends StatelessWidget {
  const _PointsPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
