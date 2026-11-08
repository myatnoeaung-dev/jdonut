import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// Greeting and member tier at the top of Home.
class MemberHeader extends StatelessWidget {
  const MemberHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(child: Text(l10n.homeGreeting, style: theme.textTheme.headlineMedium)),
        const SizedBox(width: AppSpacing.md),
        Chip(
          avatar: Icon(Icons.star_rounded, color: context.palette.link),
          label: Text(l10n.homeMemberTier),
          backgroundColor: theme.colorScheme.surface,
          side: BorderSide.none,
          shape: const StadiumBorder(),
        ),
      ],
    );
  }
}
