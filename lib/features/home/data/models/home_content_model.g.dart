// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeContentModel _$HomeContentModelFromJson(Map<String, dynamic> json) => _HomeContentModel(
  banners:
      (json['banners'] as List<dynamic>?)?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>)).toList() ??
      const <BannerModel>[],
  sections:
      (json['sections'] as List<dynamic>?)?.map((e) => HomeSectionModel.fromJson(e as Map<String, dynamic>)).toList() ??
      const <HomeSectionModel>[],
  shops:
      (json['shops'] as List<dynamic>?)?.map((e) => ShopModel.fromJson(e as Map<String, dynamic>)).toList() ??
      const <ShopModel>[],
);

Map<String, dynamic> _$HomeContentModelToJson(_HomeContentModel instance) => <String, dynamic>{
  'banners': instance.banners.map((e) => e.toJson()).toList(),
  'sections': instance.sections.map((e) => e.toJson()).toList(),
  'shops': instance.shops.map((e) => e.toJson()).toList(),
};

_BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => _BannerModel(
  id: json['id'] as String,
  tag: json['tag'] as String,
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String,
  showsShopIcon: json['showsShopIcon'] as bool? ?? false,
  position: (json['position'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BannerModelToJson(_BannerModel instance) => <String, dynamic>{
  'id': instance.id,
  'tag': instance.tag,
  'title': instance.title,
  'imageUrl': instance.imageUrl,
  'showsShopIcon': instance.showsShopIcon,
  'position': instance.position,
};

_HomeSectionModel _$HomeSectionModelFromJson(Map<String, dynamic> json) => _HomeSectionModel(
  id: json['id'] as String,
  productIds: (json['productIds'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
);

Map<String, dynamic> _$HomeSectionModelToJson(_HomeSectionModel instance) => <String, dynamic>{
  'id': instance.id,
  'productIds': instance.productIds,
};

_ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => _ShopModel(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  imageUrl: json['imageUrl'] as String,
  position: (json['position'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ShopModelToJson(_ShopModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'imageUrl': instance.imageUrl,
  'position': instance.position,
};
