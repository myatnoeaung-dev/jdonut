import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/reward_challenge.dart';

/// White card for one challenge: artwork, title, progress, EARN and points.
/// EARN is only enabled once the challenge is complete.
class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, required this.challenge, required this.onEarn});

  final RewardChallenge challenge;
  final VoidCallback onEarn;

  static Key earnButtonKey(String challengeId) => ValueKey('earn_$challengeId');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final muted = textTheme.bodySmall?.copyWith(color: context.palette.mutedText);
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
              child: _ChallengeArtwork(challenge: challenge),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
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
                      _EarnButton(key: earnButtonKey(challenge.id), onPressed: challenge.isCompleted ? onEarn : null),
                      Text(l10n.challengeReward(challenge.rewardPoints), style: muted),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The product artwork; drink challenges add an orange progress arc around it.
class _ChallengeArtwork extends StatelessWidget {
  const _ChallengeArtwork({required this.challenge});

  final RewardChallenge challenge;

  static const EdgeInsets _insideArc = EdgeInsets.all(AppSpacing.md);

  @override
  Widget build(BuildContext context) {
    final image = AppNetworkImage(path: challenge.imageUrl, semanticLabel: challenge.title);
    if (challenge.kind != ChallengeKind.drink) return image;
    return CustomPaint(
      painter: _ProgressArcPainter(completion: challenge.completion, color: context.palette.badge),
      child: Padding(padding: _insideArc, child: image),
    );
  }
}

/// A 270° gauge opening at the bottom, filled clockwise from the lower left.
class _ProgressArcPainter extends CustomPainter {
  const _ProgressArcPainter({required this.completion, required this.color});

  final double completion;
  final Color color;

  static const double _startAngle = 0.75 * math.pi; // lower left
  static const double _gaugeSweep = 1.5 * math.pi;
  static const double _strokeWidth = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_strokeWidth / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _startAngle, _gaugeSweep * completion, false, paint);
  }

  @override
  bool shouldRepaint(_ProgressArcPainter oldDelegate) =>
      oldDelegate.completion != completion || oldDelegate.color != color;
}

/// Small cyan pill; grey with white text while disabled.
class _EarnButton extends StatelessWidget {
  const _EarnButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(AppSizes.earnButtonWidth, AppSizes.earnButtonHeight),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        disabledBackgroundColor: context.palette.disabledFill,
        disabledForegroundColor: colors.surface,
      ),
      child: Text(context.l10n.earn.toUpperCase(), locale: Localizations.localeOf(context)),
    );
  }
}
