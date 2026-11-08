import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/coming_soon_view.dart';
import '../../../../core/widgets/gradient_background.dart';

/// Rewards tab: tier ladder, points ring and the two tabs (layout placeholder).
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const int _tabCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: _tabCount,
      child: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.screenH),
                child: Text(l10n.rewardsTitle, style: Theme.of(context).textTheme.headlineMedium),
              ),
              const ComingSoonView(),
              TabBar(tabs: [Tab(text: l10n.eatMoreEarnMore), Tab(text: l10n.gift)]),
              const Expanded(child: TabBarView(children: [ComingSoonView(), ComingSoonView()])),
            ],
          ),
        ),
      ),
    );
  }
}
