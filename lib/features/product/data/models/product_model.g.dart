// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => _ProductModel(
  id: json['id'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
  priceMmk: (json['priceMmk'] as num).toInt(),
  isNew: json['isNew'] as bool? ?? false,
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  imageUrl: json['imageUrl'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'priceMmk': instance.priceMmk,
  'isNew': instance.isNew,
  'discountPercent': instance.discountPercent,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
};
