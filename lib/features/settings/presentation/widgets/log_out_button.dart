import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';

/// White "Log out" row in the error colour. Asks for confirmation before
/// calling [onConfirmed].
class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () => _confirm(context),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        leading: Icon(Icons.logout_rounded, color: colors.error),
        title: Text(context.l10n.logOut, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colors.error)),
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logOutConfirmTitle),
        content: Text(l10n.logOutConfirmMessage),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.cancel)),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(l10n.logOut)),
        ],
      ),
    );
    if (confirmed ?? false) onConfirmed();
  }
}
