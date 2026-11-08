import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// Orange bell tab attached to the right screen edge, with the unread count
/// in a white circle.
class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, required this.count, this.onTap});

  final int count;
  final VoidCallback? onTap;

  static const BorderRadius _shape = BorderRadius.horizontal(left: Radius.circular(AppRadii.pill));

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Semantics(
      button: true,
      label: count > 0 ? l10n.unreadNotifications(count) : l10n.notifications,
      excludeSemantics: true,
      child: Material(
        color: palette.badge,
        borderRadius: _shape,
        child: InkWell(
          borderRadius: _shape,
          onTap: onTap ?? () {},
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppSizes.notificationButton),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_none_rounded, color: palette.onBadge),
                  if (count > 0) ...[const SizedBox(width: AppSpacing.sm), _CountBubble(count: count)],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountBubble extends StatelessWidget {
  const _CountBubble({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minWidth: AppSizes.notificationCount, minHeight: AppSizes.notificationCount),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(AppRadii.pill)),
      child: Text('$count', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colors.onSurface)),
    );
  }
}
