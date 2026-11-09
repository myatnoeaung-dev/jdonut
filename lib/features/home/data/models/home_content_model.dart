import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/home_banner.dart';
import '../../domain/entities/home_shop.dart';

part 'home_content_model.freezed.dart';
part 'home_content_model.g.dart';

/// `assets/seed/home.json` and the `/v1/home` data: banners, sections and shops.
@freezed
abstract class HomeContentModel with _$HomeContentModel {
  const factory HomeContentModel({
    @Default(<BannerModel>[]) List<BannerModel> banners,
    @Default(<HomeSectionModel>[]) List<HomeSectionModel> sections,
    @Default(<ShopModel>[]) List<ShopModel> shops,
  }) = _HomeContentModel;

  factory HomeContentModel.fromJson(Map<String, dynamic> json) => _$HomeContentModelFromJson(json);

  static HomeContentModel parse(Object? json) => HomeContentModel.fromJson(json! as Map<String, dynamic>);
}

@freezed
abstract class BannerModel with _$BannerModel {
  const factory BannerModel({
    required String id,
    required String tag,
    required String title,
    required String imageUrl,
    @Default(false) bool showsShopIcon,
    @Default(0) int position,
  }) = _BannerModel;

  const BannerModel._();

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  factory BannerModel.fromRow(BannerRow row) => BannerModel(
    id: row.id,
    tag: row.tag,
    title: row.title,
    imageUrl: row.imageUrl,
    showsShopIcon: row.showsShopIcon,
    position: row.position,
  );

  BannersCompanion toCompanion() => BannersCompanion.insert(
    id: id,
    tag: tag,
    title: title,
    imageUrl: imageUrl,
    showsShopIcon: Value(showsShopIcon),
    position: position,
  );

  HomeBanner toEntity() => HomeBanner(id: id, tag: tag, title: title, imageUrl: imageUrl, showsShopIcon: showsShopIcon);
}

/// A Home section: its id (`seasonal`, `popular`, `orderAgain`) and product ids in order.
@freezed
abstract class HomeSectionModel with _$HomeSectionModel {
  const factory HomeSectionModel({required String id, @Default(<String>[]) List<String> productIds}) =
      _HomeSectionModel;

  const HomeSectionModel._();

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) => _$HomeSectionModelFromJson(json);

  List<HomeSectionItemsCompanion> toCompanions() => [
    for (final (position, productId) in productIds.indexed)
      HomeSectionItemsCompanion.insert(sectionId: id, productId: productId, position: position),
  ];
}

@freezed
abstract class ShopModel with _$ShopModel {
  const factory ShopModel({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    @Default(0) int position,
  }) = _ShopModel;

  const ShopModel._();

  factory ShopModel.fromJson(Map<String, dynamic> json) => _$ShopModelFromJson(json);

  factory ShopModel.fromRow(ShopRow row) =>
      ShopModel(id: row.id, name: row.name, address: row.address, imageUrl: row.imageUrl, position: row.position);

  ShopsCompanion toCompanion() =>
      ShopsCompanion.insert(id: id, name: name, address: address, imageUrl: imageUrl, position: position);

  HomeShop toEntity() => HomeShop(id: id, name: name, address: address, imageUrl: imageUrl);
}
