// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num).toInt(),
  phoneNumber: json['phoneNumber'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String?,
  birthDate: DateTime.parse(json['birthDate'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'birthDate': instance.birthDate.toIso8601String(),
};
