import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/fill_viewport_scroll_view.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../widgets/donut_tile_grid.dart';

/// Shown once after registration, then the user lands on Home.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: FillViewportScrollView(
            padding: const EdgeInsets.all(AppSpacing.screenH),
            top: const DonutTileGrid(),
            bottom: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl),
                Text(l10n.welcomeTitle, style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xxxl),
                AppPrimaryButton(label: l10n.letsExplore, onPressed: () => context.go(AppRoutes.home)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
