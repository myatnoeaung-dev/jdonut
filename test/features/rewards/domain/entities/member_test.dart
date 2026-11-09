import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/rewards/domain/entities/member.dart';

Member _member(MemberTier tier, {int points = 500, int nextTierPoints = 1000}) =>
    Member(id: 'm', tier: tier, loyaltyPoints: points, nextTierPoints: nextTierPoints, unreadNotifications: 0);

void main() {
  test('the next tier after bronze is silver, then gold, then platinum, then none', () {
    expect(MemberTier.bronze.next, MemberTier.silver);
    expect(MemberTier.silver.next, MemberTier.gold);
    expect(MemberTier.gold.next, MemberTier.platinum);
    expect(MemberTier.platinum.next, isNull);
  });

  test('pointsToNextTier is what is left before the next tier starts', () {
    expect(_member(MemberTier.silver).pointsToNextTier, 500);
  });

  test('pointsToNextTier never goes below zero', () {
    expect(_member(MemberTier.silver, points: 1200).pointsToNextTier, 0);
  });

  test('a platinum member has no next tier and no points to go', () {
    final platinum = _member(MemberTier.platinum);

    expect(platinum.nextTier, isNull);
    expect(platinum.pointsToNextTier, 0);
  });

  test('tierProgress is the share of the next tier points already earned', () {
    expect(_member(MemberTier.silver).tierProgress, 0.5);
  });

  test('tierProgress stays between 0 and 1', () {
    expect(_member(MemberTier.silver, points: 1500).tierProgress, 1);
    expect(_member(MemberTier.silver, points: 0).tierProgress, 0);
  });

  test('tierProgress is full at the top tier', () {
    expect(_member(MemberTier.platinum, points: 0).tierProgress, 1);
  });
}
