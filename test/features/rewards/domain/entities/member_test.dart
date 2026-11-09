import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/rewards/domain/entities/member.dart';

Member _member(MemberTier tier, {int points = 500, int nextTierPoints = 1000}) =>
    Member(id: 'm', tier: tier, loyaltyPoints: points, nextTierPoints: nextTierPoints, unreadNotifications: 0);

void main() {
  test('the next tier after bronze is silver, then gold, then none', () {
    expect(MemberTier.bronze.next, MemberTier.silver);
    expect(MemberTier.silver.next, MemberTier.gold);
    expect(MemberTier.gold.next, isNull);
  });

  test('pointsToNextTier is what is left before the next tier starts', () {
    expect(_member(MemberTier.silver).pointsToNextTier, 500);
  });

  test('pointsToNextTier never goes below zero', () {
    expect(_member(MemberTier.silver, points: 1200).pointsToNextTier, 0);
  });

  test('a gold member has no next tier and no points to go', () {
    final gold = _member(MemberTier.gold);

    expect(gold.nextTier, isNull);
    expect(gold.pointsToNextTier, 0);
  });
}
