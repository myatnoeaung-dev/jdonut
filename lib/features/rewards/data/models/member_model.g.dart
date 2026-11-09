// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => _MemberModel(
  id: json['id'] as String,
  tier: json['tier'] as String,
  loyaltyPoints: (json['loyaltyPoints'] as num).toInt(),
  nextTierPoints: (json['nextTierPoints'] as num).toInt(),
  unreadNotifications: (json['unreadNotifications'] as num?)?.toInt() ?? 0,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$MemberModelToJson(_MemberModel instance) => <String, dynamic>{
  'id': instance.id,
  'tier': instance.tier,
  'loyaltyPoints': instance.loyaltyPoints,
  'nextTierPoints': instance.nextTierPoints,
  'unreadNotifications': instance.unreadNotifications,
  'avatarUrl': instance.avatarUrl,
};
