import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/member.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
abstract class MemberModel with _$MemberModel {
  const factory MemberModel({
    required String id,
    required String tier,
    required int loyaltyPoints,
    required int nextTierPoints,
    @Default(0) int unreadNotifications,
    String? avatarUrl,
  }) = _MemberModel;

  const MemberModel._();

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

  /// Parses `assets/seed/member.json` or the `/v1/members/me` data.
  static MemberModel parse(Object? json) => MemberModel.fromJson(json! as Map<String, dynamic>);

  factory MemberModel.fromRow(MemberRow row) => MemberModel(
    id: row.id,
    tier: row.tier,
    loyaltyPoints: row.loyaltyPoints,
    nextTierPoints: row.nextTierPoints,
    unreadNotifications: row.unreadNotifications,
    avatarUrl: row.avatarUrl,
  );

  MembersCompanion toCompanion() => MembersCompanion.insert(
    id: id,
    tier: tier,
    loyaltyPoints: loyaltyPoints,
    nextTierPoints: nextTierPoints,
    unreadNotifications: Value(unreadNotifications),
    avatarUrl: Value(avatarUrl),
  );

  /// An unknown tier name falls back to the lowest tier rather than failing.
  Member toEntity() => Member(
    id: id,
    tier: MemberTier.values.asNameMap()[tier] ?? MemberTier.bronze,
    loyaltyPoints: loyaltyPoints,
    nextTierPoints: nextTierPoints,
    unreadNotifications: unreadNotifications,
    avatarUrl: avatarUrl,
  );
}
