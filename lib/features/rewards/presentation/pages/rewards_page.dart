import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/coming_soon_view.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/state_views.dart';
import '../bloc/member/member_bloc.dart';
import '../widgets/member_points_card.dart';

/// Rewards tab: the member's tier and points (the same record Home shows) and
/// the two tabs (layout placeholder).
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const int _tabCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => getIt<MemberBloc>()..add(const MemberStarted()),
      child: DefaultTabController(
        length: _tabCount,
        child: GradientBackground(
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Scrolls on small phones with large text instead of squeezing the tabs.
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH,
                      AppSpacing.screenH,
                      AppSpacing.screenH,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(l10n.rewardsTitle, style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: AppSpacing.lg),
                        const _MemberSummary(),
                      ],
                    ),
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(text: l10n.eatMoreEarnMore),
                    Tab(text: l10n.gift),
                  ],
                ),
                const Expanded(child: TabBarView(children: [ComingSoonView(), ComingSoonView()])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MemberSummary extends StatelessWidget {
  const _MemberSummary();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      builder: (context, state) {
        final member = state.member;
        if (member != null) return MemberPointsCard(member: member);
        if (state.failure != null) {
          return ErrorView(onRetry: () => context.read<MemberBloc>().add(const MemberStarted()));
        }
        return const LoadingView();
      },
    );
  }
}
