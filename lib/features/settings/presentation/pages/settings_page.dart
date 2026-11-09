import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_info.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/l10n/app_language.dart';
import '../../../../core/l10n/locale_controller.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/coming_soon_snack_bar.dart';
import '../../../../core/widgets/status_bar_strip.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../home/presentation/widgets/member_tier_label.dart';
import '../../../rewards/presentation/bloc/member/member_bloc.dart';
import '../widgets/language_sheet.dart';
import '../widgets/log_out_button.dart';
import '../widgets/settings_profile_header.dart';
import '../widgets/settings_section.dart';

/// Settings tab. Language and Log out work; the other rows show "Coming soon".
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MemberBloc>()..add(const MemberStarted()),
      child: ColoredBox(
        color: context.palette.pageBackground,
        child: const CustomScrollView(
          slivers: [
            StatusBarStrip(),
            // Floating, not pinned: scrolls away going down and slides back in on any
            // upward scroll. Sized by its content, so large text and Burmese still fit.
            SliverFloatingHeader(child: _MemberHeader()),
            SliverToBoxAdapter(child: _AccountSection()),
            SliverToBoxAdapter(child: _PreferencesSection()),
            SliverToBoxAdapter(child: _SupportSection()),
            SliverToBoxAdapter(child: _Footer()),
          ],
        ),
      ),
    );
  }
}

/// The signed-in member's name and phone, and the tier from the shared member record.
class _MemberHeader extends StatelessWidget {
  const _MemberHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final auth = context.watch<AuthBloc>().state;
    final member = context.select((MemberBloc bloc) => bloc.state.member);
    final user = auth is Authenticated ? auth.user : null;
    final fullName = [?user?.firstName, ?user?.lastName].join(' ');
    return SettingsProfileHeader(
      name: fullName,
      phoneNumber: user?.phoneNumber ?? '',
      tierLabel: member == null ? '' : l10n.memberTier(memberTierName(l10n, member.tier)),
      avatarPath: member?.avatarUrl,
      onEdit: () => showComingSoon(context),
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void comingSoon() => showComingSoon(context);
    return SettingsSection(
      title: l10n.settingsAccount,
      tiles: [
        SettingsTile(icon: Icons.person_outline_rounded, title: l10n.editProfile, onTap: comingSoon),
        SettingsTile(icon: Icons.location_on_outlined, title: l10n.myAddresses, onTap: comingSoon),
        SettingsTile(icon: Icons.receipt_long_outlined, title: l10n.orderHistory, onTap: comingSoon),
      ],
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  const _PreferencesSection();

  Future<void> _changeLanguage(BuildContext context, AppLanguage current) async {
    final picked = await showLanguageSheet(context, current: current);
    if (picked != null) getIt<LocaleController>().setLanguage(picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final current = AppLanguage.fromLocale(Localizations.localeOf(context));
    return SettingsSection(
      title: l10n.settingsPreferences,
      tiles: [
        SettingsTile(
          icon: Icons.translate_rounded,
          title: l10n.language,
          value: current.nativeName,
          onTap: () => _changeLanguage(context, current),
        ),
      ],
    );
  }
}

class _SupportSection extends StatelessWidget {
  const _SupportSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void comingSoon() => showComingSoon(context);
    return SettingsSection(
      title: l10n.settingsSupport,
      tiles: [
        SettingsTile(icon: Icons.help_outline_rounded, title: l10n.helpCenter, onTap: comingSoon),
        SettingsTile(icon: Icons.description_outlined, title: l10n.termsOfUse, onTap: comingSoon),
        SettingsTile(icon: Icons.privacy_tip_outlined, title: l10n.privacyPolicy, onTap: comingSoon),
        SettingsTile(icon: Icons.info_outline_rounded, title: l10n.aboutApp, value: AppInfo.version, onTap: comingSoon),
      ],
    );
  }
}

/// Log out, version, and room for the floating bottom navigation bar.
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(AppSpacing.homeH, AppSpacing.xxl, AppSpacing.homeH, bottomInset + AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LogOutButton(onConfirmed: () => context.read<AuthBloc>().add(const AuthLogOutRequested())),
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
