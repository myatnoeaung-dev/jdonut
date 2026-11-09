import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../home/presentation/widgets/member_tier_label.dart';
import '../../domain/entities/member.dart';

/// Tier, points balance and points to the next tier, from the shared member record.
class MemberPointsCard extends StatelessWidget {
  const MemberPointsCard({super.key, required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final nextTier = member.nextTier;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.memberTier(memberTierName(l10n, member.tier)), style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.loyaltyPoints(member.loyaltyPoints), style: textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              nextTier == null
                  ? l10n.topTierReached
                  : l10n.pointsToNextTier(member.pointsToNextTier, memberTierName(l10n, nextTier)),
              style: textTheme.bodyMedium?.copyWith(color: context.palette.mutedText),
            ),
          ],
        ),
      ),
    );
  }
}
