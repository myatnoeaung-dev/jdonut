import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';

/// A titled white card grouping [SettingsTile]s.
class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.title, required this.tiles});

  final String title;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.homeH, AppSpacing.xxl, AppSpacing.homeH, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: AppSpacing.sm),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: context.palette.mutedText),
            ),
          ),
          Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            clipBehavior: Clip.antiAlias,
            child: Column(children: tiles),
          ),
        ],
      ),
    );
  }
}

/// One settings row: tinted icon, title, then a value + chevron or a switch.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
    this.switchValue,
    this.onSwitchChanged,
  });

  final IconData icon;
  final String title;

  /// Current value shown before the chevron, e.g. "English".
  final String? value;
  final VoidCallback? onTap;

  /// When set, the row shows a switch instead of a chevron.
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  Widget build(BuildContext context) {
    final switchValue = this.switchValue;
    return ListTile(
      onTap: switchValue == null ? onTap : () => onSwitchChanged?.call(!switchValue),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      leading: _IconBox(icon: icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: switchValue == null
          ? _ValueAndChevron(value: value)
          : Switch(value: switchValue, onChanged: onSwitchChanged),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon});

  final IconData icon;

  static const double _tintAlpha = 0.15;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      width: AppSizes.settingsIconBox,
      height: AppSizes.settingsIconBox,
      decoration: BoxDecoration(
        color: primary.withValues(alpha: _tintAlpha),
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Icon(icon, color: primary, size: AppSizes.settingsIcon),
    );
  }
}

class _ValueAndChevron extends StatelessWidget {
  const _ValueAndChevron({this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    final muted = context.palette.mutedText;
    final value = this.value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null) Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: muted)),
        Icon(Icons.chevron_right_rounded, color: muted),
      ],
    );
  }
}
