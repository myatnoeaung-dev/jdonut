import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../extensions/l10n_extension.dart';
import '../theme/app_dimens.dart';
import 'press_scale.dart';

/// White rounded-square back arrow used at the top of each step.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  /// Defaults to popping the current route.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: context.l10n.back,
      child: PressScale(
        child: Material(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadii.xs),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.xs),
            onTap: onPressed ?? () => _goBack(context),
            child: SizedBox.square(
              dimension: AppSizes.backButton,
              child: Icon(Icons.arrow_back, size: AppSizes.backIcon, color: colors.onSurface),
            ),
          ),
        ),
      ),
    );
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) context.pop();
  }
}
