import '../../../../l10n/app_localizations.dart';
import '../../../rewards/domain/entities/member.dart';

/// Localized tier name: Bronze, Silver, Gold.
String memberTierName(AppLocalizations l10n, MemberTier tier) => switch (tier) {
  MemberTier.bronze => l10n.tierBronze,
  MemberTier.silver => l10n.tierSilver,
  MemberTier.gold => l10n.tierGold,
};
