import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/app_svg_icon.dart';

/// Google / Apple / Facebook sign-in icons on the onboarding screen.
class SocialSignInRow extends StatelessWidget {
  const SocialSignInRow({super.key, this.onGoogle, this.onApple, this.onFacebook});

  final VoidCallback? onGoogle;
  final VoidCallback? onApple;
  final VoidCallback? onFacebook;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appleTint = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.xxl,
      children: [
        _SocialButton(asset: AppIcons.google, label: l10n.continueWithGoogle, onTap: onGoogle),
        _SocialButton(asset: AppIcons.apple, label: l10n.continueWithApple, onTap: onApple, tint: appleTint),
        _SocialButton(asset: AppIcons.facebook, label: l10n.continueWithFacebook, onTap: onFacebook),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.asset, required this.label, this.onTap, this.tint});

  final String asset;
  final String label;
  final VoidCallback? onTap;

  /// Only for single-colour logos (Apple); multi-colour logos stay untinted.
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () {},
      tooltip: label,
      constraints: const BoxConstraints.tightFor(width: AppSizes.socialTapTarget, height: AppSizes.socialTapTarget),
      icon: AppSvgIcon(asset, size: AppSizes.socialIcon, currentColor: tint, semanticLabel: label),
    );
  }
}
