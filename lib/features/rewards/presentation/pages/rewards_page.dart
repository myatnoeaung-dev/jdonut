import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/coming_soon_snack_bar.dart';
import '../../../../core/widgets/coming_soon_view.dart';
import '../../../../core/widgets/entrance_animation.dart';
import '../../../../core/widgets/pill_tab_bar.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../../core/widgets/status_bar_strip.dart';
import '../../../../core/widgets/tab_fade_transition.dart';
import '../../domain/entities/reward_challenge.dart';
import '../bloc/member/member_bloc.dart';
import '../sample/sample_reward_challenges.dart';
import '../widgets/challenge_card.dart';
import '../widgets/points_ring.dart';
import '../widgets/rewards_header.dart';
import '../widgets/tier_ladder.dart';

/// Rewards tab: tier ladder and points ring from the shared member record
/// (the same one Home shows), then the "Eat more earn more" and "Gift" tabs.
///
/// Challenges are sample data for now; EARN only gives press feedback.
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const List<RewardChallenge> _challenges = sampleRewardChallenges;
  static const int _tabCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final surface = Theme.of(context).colorScheme.surface;
    return BlocProvider(
      create: (_) => getIt<MemberBloc>()..add(const MemberStarted()),
      child: DefaultTabController(
        length: _tabCount,
        child: ColoredBox(
          color: context.palette.pageBackground,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              StatusBarStrip(color: surface),
              const SliverToBoxAdapter(child: _RewardsSummaryPanel(challenges: _challenges)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.homeH, vertical: AppSpacing.sm),
                  child: PillTabBar(labels: [l10n.eatMoreEarnMore, l10n.gift]),
                ),
              ),
            ],
            body: const TabBarView(
              children: [
                TabFadeTransition(index: 0, child: _ChallengeList(challenges: _challenges)),
                TabFadeTransition(index: 1, child: _GiftTab()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// White panel: title with the ready-rewards pill, tier ladder and points ring.
class _RewardsSummaryPanel extends StatelessWidget {
  const _RewardsSummaryPanel({required this.challenges});

  final List<RewardChallenge> challenges;

  @override
  Widget build(BuildContext context) {
    final readyCount = challenges.where((challenge) => challenge.isCompleted).length;
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RewardsHeader(readyCount: readyCount, onRewardsTap: () => showComingSoon(context)),
          const Padding(
            padding: EdgeInsets.fromLTRB(AppSpacing.screenH, AppSpacing.xl, AppSpacing.lg, AppSpacing.xl),
            child: _MemberProgress(),
          ),
        ],
      ),
    );
  }
}

/// Tier ladder beside the points ring, with loading and error states.
class _MemberProgress extends StatelessWidget {
  const _MemberProgress();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      builder: (context, state) {
        final member = state.member;
        if (member != null) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: TierLadder(member: member)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: PointsRing(points: member.loyaltyPoints, progress: member.tierProgress),
              ),
            ],
          );
        }
        if (state.failure != null) {
          return ErrorView(onRetry: () => context.read<MemberBloc>().add(const MemberStarted()));
        }
        return const LoadingView();
      },
    );
  }
}

/// Challenge cards that enter one after another each time the tab is shown.
class _ChallengeList extends StatelessWidget {
  const _ChallengeList({required this.challenges});

  final List<RewardChallenge> challenges;

  /// Cards further down enter together with this one, so none waits long.
  static const int _lastStaggeredIndex = 5;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) return EmptyView(message: context.l10n.rewardsEmpty);
    return ListView.separated(
      // Bottom padding includes the floating navigation bar.
      padding: EdgeInsets.fromLTRB(
        AppSpacing.homeH,
        AppSpacing.sm,
        AppSpacing.homeH,
        AppSpacing.xxl + MediaQuery.paddingOf(context).bottom,
      ),
      itemCount: challenges.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
      itemBuilder: (context, index) => _staggeredCard(challenges[index], index),
    );
  }

  /// EARN gives press feedback only; claiming isn't built yet.
  Widget _staggeredCard(RewardChallenge challenge, int index) {
    final delay = AppDurations.staggerStep * math.min(index, _lastStaggeredIndex);
    return EntranceAnimation(
      delay: delay,
      child: ChallengeCard(challenge: challenge, revealDelay: delay + AppDurations.entrance),
    );
  }
}

class _GiftTab extends StatelessWidget {
  const _GiftTab();

  @override
  Widget build(BuildContext context) => ListView(children: const [ComingSoonView()]);
}
