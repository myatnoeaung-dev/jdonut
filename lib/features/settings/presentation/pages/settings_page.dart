import 'package:flutter/material.dart';

import '../../../../core/constants/app_info.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/l10n/app_language.dart';
import '../../../../core/l10n/locale_controller.dart';
import '../../../../core/session/auth_session.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/status_bar_strip.dart';
import '../../../home/presentation/sample/home_sample_content.dart';
import '../../../home/presentation/widgets/member_tier_label.dart';
import '../widgets/language_sheet.dart';
import '../widgets/log_out_button.dart';
import '../widgets/settings_profile_header.dart';
import '../widgets/settings_section.dart';

/// Settings tab. Language and Log out work; the other rows are placeholders
/// that show "Coming soon".
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _localeController = getIt<LocaleController>();


  void _showComingSoon() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.featureComingSoon)));
  }

  Future<void> _changeLanguage(AppLanguage current) async {
    final picked = await showLanguageSheet(context, current: current);
    if (picked != null) _localeController.setLanguage(picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const member = HomeSampleContent.member;
    return ColoredBox(
      color: context.palette.pageBackground,
      child: CustomScrollView(
        slivers: [
          const StatusBarStrip(),
          // Floating, not pinned: scrolls away going down and slides back in on any
          // upward scroll. Sized by its content, so large text and Burmese still fit.
          SliverFloatingHeader(
            child: SettingsProfileHeader(
              name: member.firstName,
              phoneNumber: member.phoneNumber,
              tierLabel: l10n.memberTier(memberTierName(l10n, member.tier)),
              avatarPath: member.avatarPath,
              onEdit: _showComingSoon,
            ),
          ),
          SliverToBoxAdapter(child: _accountSection()),
          SliverToBoxAdapter(child: _preferencesSection()),
          SliverToBoxAdapter(child: _supportSection()),
          SliverToBoxAdapter(child: _footer()),
        ],
      ),
    );
  }

  Widget _accountSection() {
    final l10n = context.l10n;
    return SettingsSection(
      title: l10n.settingsAccount,
      tiles: [
        SettingsTile(icon: Icons.person_outline_rounded, title: l10n.editProfile, onTap: _showComingSoon),
        SettingsTile(icon: Icons.location_on_outlined, title: l10n.myAddresses, onTap: _showComingSoon),
        SettingsTile(icon: Icons.receipt_long_outlined, title: l10n.orderHistory, onTap: _showComingSoon),
      ],
    );
  }

  Widget _preferencesSection() {
    final l10n = context.l10n;
    final current = AppLanguage.fromLocale(Localizations.localeOf(context));
    return SettingsSection(
      title: l10n.settingsPreferences,
      tiles: [
        SettingsTile(
          icon: Icons.translate_rounded,
          title: l10n.language,
          value: current.nativeName,
          onTap: () => _changeLanguage(current),
        ),
      
      ],
    );
  }

  Widget _supportSection() {
    final l10n = context.l10n;
    return SettingsSection(
      title: l10n.settingsSupport,
      tiles: [
        SettingsTile(icon: Icons.help_outline_rounded, title: l10n.helpCenter, onTap: _showComingSoon),
        SettingsTile(icon: Icons.description_outlined, title: l10n.termsOfUse, onTap: _showComingSoon),
        SettingsTile(icon: Icons.privacy_tip_outlined, title: l10n.privacyPolicy, onTap: _showComingSoon),
        SettingsTile(
          icon: Icons.info_outline_rounded,
          title: l10n.aboutApp,
          value: AppInfo.version,
          onTap: _showComingSoon,
        ),
      ],
    );
  }

  /// Log out, version, and room for the floating bottom navigation bar.
  Widget _footer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.homeH,
        AppSpacing.xxl,
        AppSpacing.homeH,
        MediaQuery.paddingOf(context).bottom + AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LogOutButton(onConfirmed: getIt<AuthSession>().signOut),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.appVersion(AppInfo.version),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: context.palette.mutedText),
          ),
        ],
      ),
    );
  }
}
