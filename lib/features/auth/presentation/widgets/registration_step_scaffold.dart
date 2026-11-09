import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_primary_button.dart';
import '../../../../core/widgets/entrance_animation.dart';
import '../../../../core/widgets/fill_viewport_scroll_view.dart';
import '../../../../core/widgets/gradient_background.dart';
import 'registration_progress_ring.dart';
import 'terms_notice.dart';

/// Shared layout of the four registration steps: back button + progress ring,
/// title, step content, then CONTINUE and the terms notice at the bottom.
class RegistrationStepScaffold extends StatelessWidget {
  const RegistrationStepScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.children,
    this.onContinue,
    this.showContinue = true,
    this.isContinueEnabled = true,
    this.isLoading = false,
  });

  static const int totalSteps = 4;

  final int step;
  final String title;
  final List<Widget> children;
  final VoidCallback? onContinue;
  final bool showContinue;

  /// False greys out CONTINUE (e.g. while the phone number is invalid).
  final bool isContinueEnabled;

  /// Spinner on CONTINUE during the fake network call.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
              child: FillViewportScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH, vertical: AppSpacing.xl),
                top: _topGroup(context),
                bottom: _bottomGroup(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topGroup(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppBackButton(),
            RegistrationProgressRing(step: step, totalSteps: totalSteps),
          ],
        ),
        const SizedBox(height: AppSpacing.xxxl),
        // Title, then the step's fields, enter just after the page slides in.
        ...EntranceAnimation.staggered(delay: AppDurations.stepContentDelay, [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.xxl),
          ...children,
        ]),
      ],
    );
  }

  Widget _bottomGroup(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.xxl),
        if (showContinue)
          AppPrimaryButton(
            label: context.l10n.continueLabel,
            isLoading: isLoading,
            onPressed: isContinueEnabled || isLoading ? onContinue : null,
          ),
        const SizedBox(height: AppSpacing.xxl),
        const TermsNotice(),
      ],
    );
  }
}
