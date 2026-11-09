import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/ringed_avatar.dart';

/// Peach panel at the top of Settings: title, avatar, name, phone and tier,
/// with an edit button.
class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.tierLabel,
    required this.avatarPath,
    this.onEdit,
  });

  final String name;
  final String phoneNumber;

  /// Already localized, e.g. "Bronze member".
  final String tierLabel;

  /// Bundled asset path or network URL; null shows the initial.
  final String? avatarPath;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSizes.homePanelRadius)),
      child: ColoredBox(
        color: context.palette.headerBackground,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.homeH, AppSpacing.lg, AppSpacing.homeH, AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.navSettings, style: textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  RingedAvatar(imagePath: avatarPath, initial: name.isEmpty ? '' : name.characters.first),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: _Identity(name: name, phoneNumber: phoneNumber, tierLabel: tierLabel),
                  ),
                  _EditButton(onPressed: onEdit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Identity extends StatelessWidget {
  const _Identity({required this.name, required this.phoneNumber, required this.tierLabel});

  final String name;
  final String phoneNumber;
  final String tierLabel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: AppSpacing.xs),
        Text(phoneNumber, style: textTheme.bodyMedium),
        if (tierLabel.isNotEmpty) ...[const SizedBox(height: AppSpacing.sm), _TierPill(label: tierLabel)],
      ],
    );
  }
}

class _TierPill extends StatelessWidget {
  const _TierPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, size: AppSizes.settingsTierIcon, color: palette.badge),
            const SizedBox(width: AppSpacing.xs),
            Flexible(child: Text(label, style: Theme.of(context).textTheme.bodySmall)),
          ],
        ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      tooltip: context.l10n.editProfile,
      style: IconButton.styleFrom(backgroundColor: colors.surface, foregroundColor: colors.onSurface),
      icon: const Icon(Icons.edit_outlined),
    );
  }
}
