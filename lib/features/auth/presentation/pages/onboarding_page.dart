import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/fill_viewport_scroll_view.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/widgets/highlighted_text.dart';
import '../widgets/onboarding_hero.dart';
import '../widgets/social_sign_in_row.dart';
import '../widgets/terms_notice.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const double _heroHeightFactor = 0.48;
  static const double _heroMinHeight = 200;

  @override
  Widget build(BuildContext context) {
    final heroHeight = (MediaQuery.sizeOf(context).height * _heroHeightFactor).clamp(_heroMinHeight, double.infinity);
    return Scaffold(
      body: GradientBackground(
        child: FillViewportScrollView(
          top: SizedBox(height: heroHeight, child: const OnboardingHero()),
          bottom: const SafeArea(top: false, child: Center(child: _OnboardingActions())),
        ),
      ),
    );
  }
}

class _OnboardingActions extends StatelessWidget {
  const _OnboardingActions();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.screenH, 0, AppSpacing.screenH, AppSpacing.xl),
        child: Column(
          children: [
            Text(l10n.onboardingTitle, style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xxxl),
            AppPrimaryButton(
              label: l10n.getStarted,
              onPressed: () => context.push(AppRoutes.phoneFor(AuthFlow.register)),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _LogInPrompt(),
            const SizedBox(height: AppSpacing.lg),
            const SocialSignInRow(),
            const SizedBox(height: AppSpacing.lg),
            const TermsNotice(),
          ],
        ),
      ),
    );
  }
}

/// "Already have an account? Log in"
class _LogInPrompt extends StatelessWidget {
  const _LogInPrompt();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return HighlightedText(
      message: '${l10n.alreadyHaveAccount} ${HighlightedText.token(0)}',
      highlights: [HighlightSpan(l10n.logIn, onTap: () => context.push(AppRoutes.phoneFor(AuthFlow.login)))],
      style: Theme.of(context).textTheme.bodyMedium,
      highlightStyle: TextStyle(color: context.palette.link, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}
