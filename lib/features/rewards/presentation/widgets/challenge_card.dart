import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../domain/entities/reward_challenge.dart';
import 'challenge_artwork.dart';
import 'earn_button.dart';

/// White card for one challenge: artwork, title, progress, EARN and points.
/// EARN is only enabled once the challenge is complete.
///
/// [revealDelay] is when the card has finished entering: the artwork then
/// fills with progress, and a ready EARN button pulses after that.
class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, required this.challenge, this.onEarn, this.revealDelay = Duration.zero});

  final RewardChallenge challenge;
  final VoidCallback? onEarn;
  final Duration revealDelay;

  static Key earnButtonKey(String challengeId) => ValueKey('earn_$challengeId');

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            SizedBox.square(
              dimension: AppSizes.challengeArtwork,
              child: ChallengeArtwork(challenge: challenge, delay: revealDelay),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(child: _details(context)),
          ],
        ),
      ),
    );
  }

  Widget _details(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(challenge.title, style: textTheme.titleSmall, maxLines: 2, overflow: TextOverflow.ellipsis),
        Text(l10n.challengeProgress(challenge.progress, challenge.goal), style: textTheme.bodySmall),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            EarnButton(
              key: earnButtonKey(challenge.id),
              isReady: challenge.isCompleted,
              onPressed: onEarn,
              attentionDelay: revealDelay + AppDurations.progressFill,
            ),
            Text(
              l10n.challengeReward(challenge.rewardPoints),
              style: textTheme.bodySmall?.copyWith(color: context.palette.mutedText),
            ),
          ],
        ),
      ],
    );
  }
}
