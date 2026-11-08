import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/l10n/app_language.dart';
import '../../../../core/theme/app_dimens.dart';

/// Bottom sheet listing the app's languages; returns the one tapped.
Future<AppLanguage?> showLanguageSheet(BuildContext context, {required AppLanguage current}) {
  return showModalBottomSheet<AppLanguage>(
    context: context,
    showDragHandle: true,
    builder: (_) => _LanguageSheet(current: current),
  );
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet({required this.current});

  final AppLanguage current;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.xxl, 0, AppSpacing.xxl, AppSpacing.md),
            child: Text(context.l10n.chooseLanguage, style: Theme.of(context).textTheme.titleLarge),
          ),
          for (final language in AppLanguage.values)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              title: Text(language.nativeName, style: Theme.of(context).textTheme.bodyLarge),
              selected: language == current,
              trailing: language == current ? Icon(Icons.check_circle_rounded, color: colors.primary) : null,
              onTap: () => Navigator.of(context).pop(language),
            ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
