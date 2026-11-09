import 'package:equatable/equatable.dart';

enum MemberTier {
  bronze,
  silver,
  gold;

  /// The tier above this one; null at the top tier.
  MemberTier? get next => this == gold ? null : MemberTier.values[index + 1];
}

/// The member's loyalty record. Home, Rewards and Settings all show this one
/// record, so the tier and points always match across screens.
class Member extends Equatable {
  const Member({
    required this.id,
    required this.tier,
    required this.loyaltyPoints,
    required this.nextTierPoints,
    required this.unreadNotifications,
    this.avatarUrl,
  });

  final String id;
  final MemberTier tier;
  final int loyaltyPoints;

  /// Points at which the next tier starts.
  final int nextTierPoints;
  final int unreadNotifications;

  /// Bundled asset path or network URL; null shows the name's initial.
  final String? avatarUrl;

  MemberTier? get nextTier => tier.next;

  /// Points still needed for [nextTier]; 0 at the top tier.
  int get pointsToNextTier {
    if (nextTier == null) return 0;
    final remaining = nextTierPoints - loyaltyPoints;
    return remaining > 0 ? remaining : 0;
  }

  @override
  List<Object?> get props => [id, tier, loyaltyPoints, nextTierPoints, unreadNotifications, avatarUrl];
}
