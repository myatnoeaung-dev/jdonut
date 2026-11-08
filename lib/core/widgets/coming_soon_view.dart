import 'package:flutter/material.dart';

import '../extensions/l10n_extension.dart';
import '../theme/app_dimens.dart';
import '../theme/app_palette.dart';

/// Placeholder for screen parts whose design hasn't been provided yet.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.donut_small_rounded, color: palette.progressTrack, size: AppSpacing.huge),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.comingSoon,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: palette.mutedText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
