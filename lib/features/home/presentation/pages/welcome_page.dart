import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/entrance_animation.dart';
import '../../../../core/widgets/fill_viewport_scroll_view.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../widgets/welcome_collage.dart';

/// Shown once after registration, then the user lands on Home.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: FillViewportScrollView(
          top: const WelcomeCollage(),
          bottom: const SafeArea(top: false, child: Center(child: _WelcomeActions())),
        ),
      ),
    );
  }
}

class _WelcomeActions extends StatelessWidget {
  const _WelcomeActions();

  static const Duration _buttonDelay = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.screenH, AppSpacing.lg, AppSpacing.screenH, AppSpacing.huge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // The title fades up once the tiles have landed, then the button.
          children: EntranceAnimation.staggered(delay: WelcomeCollage.settleTime, step: _buttonDelay, [
            Text(l10n.welcomeTitle, style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xxxl),
            AppPrimaryButton(label: l10n.letsExplore, onPressed: () => context.go(AppRoutes.home)),
          ]),
        ),
      ),
    );
  }
}
