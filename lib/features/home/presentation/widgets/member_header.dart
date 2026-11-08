import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/ringed_avatar.dart';
import '../sample/home_sample_content.dart';
import 'member_tier_label.dart';

/// Ringed avatar, name, tier and the points-to-next-tier pill.
class MemberHeader extends StatelessWidget {
  const MemberHeader({super.key, required this.member, this.nameRowEndSpace = 0});

  final HomeMember member;

  /// Room kept free at the end of the name row (for the bell tab).
  final double nameRowEndSpace;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RingedAvatar(imagePath: member.avatarPath, initial: member.firstName.characters.first),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.firstName, style: textTheme.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: AppSpacing.xs),
                  Text(l10n.memberTier(memberTierName(l10n, member.tier)), style: textTheme.bodyMedium),
                ],
              ),
            ),
            SizedBox(width: nameRowEndSpace),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _PointsPill(text: l10n.pointsToNextTier(member.pointsToNextTier, memberTierName(l10n, member.nextTier))),
      ],
    );
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
