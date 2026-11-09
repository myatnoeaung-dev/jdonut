import 'package:flutter/material.dart';

import '../extensions/l10n_extension.dart';
import '../theme/app_dimens.dart';
import '../theme/app_motion.dart';
import '../theme/app_palette.dart';
import 'entrance_animation.dart';

/// Full-area spinner for a screen's first load.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  static const Key spinnerKey = Key('loadingView');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(key: spinnerKey, semanticsLabel: context.l10n.loading),
    );
  }
}

/// A screen that couldn't load, with a "Try again" button.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.onRetry, this.message});

  /// Defaults to the generic "Something went wrong."
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _MessageView(
      icon: Icons.cloud_off_rounded,
      message: message ?? l10n.errorGeneric,
      action: FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
    );
  }
}

/// Nothing to show yet, with an optional action (e.g. refresh).
class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.message, this.actionLabel, this.onAction});

  /// Defaults to the generic "Nothing here yet."
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final label = actionLabel;
    return _MessageView(
      icon: Icons.inbox_outlined,
      message: message ?? context.l10n.emptyGeneric,
      action: label == null || onAction == null ? null : OutlinedButton(onPressed: onAction, child: Text(label)),
    );
  }
}

/// Icon, message and an optional button, centred and scrollable so large text never overflows.
class _MessageView extends StatelessWidget {
  const _MessageView({required this.icon, required this.message, this.action});

  final IconData icon;
  final String message;
  final Widget? action;

  static const double _iconScaleFrom = 0.5;

  @override
  Widget build(BuildContext context) {
    final buttonAction = action;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The icon pops in; the message and button follow.
            EntranceAnimation(
              offset: Offset.zero,
              scaleFrom: _iconScaleFrom,
              curve: AppCurves.pop,
              child: Icon(icon, size: AppSizes.stateIcon, color: context.palette.mutedText),
            ),
            const SizedBox(height: AppSpacing.lg),
            EntranceAnimation(
              delay: AppDurations.staggerStep,
              child: Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
            ),
            if (buttonAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              EntranceAnimation(delay: AppDurations.staggerStep * 2, child: buttonAction),
            ],
          ],
        ),
      ),
    );
  }
}
