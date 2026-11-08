import '../../../../l10n/app_localizations.dart';
import '../sample/home_sample_content.dart';

/// Localized tier name: Bronze, Silver, Gold.
String memberTierName(AppLocalizations l10n, MemberTier tier) => switch (tier) {
  MemberTier.bronze => l10n.tierBronze,
  MemberTier.silver => l10n.tierSilver,
  MemberTier.gold => l10n.tierGold,
};
