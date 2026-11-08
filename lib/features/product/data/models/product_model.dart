import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    @Default(false) bool isNew,
    int? discountPercent,
    required String imageUrl,
    required String description,
  }) = _ProductModel;

  const ProductModel._();

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.fromRow(ProductRow row) => ProductModel(
    id: row.id,
    code: row.code,
    name: row.name,
    priceMmk: row.priceMmk,
    isNew: row.isNew,
    discountPercent: row.discountPercent,
    imageUrl: row.imageUrl,
    description: row.description,
  );

  ProductsCompanion toCompanion() => ProductsCompanion.insert(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: Value(isNew),
    discountPercent: Value(discountPercent),
    imageUrl: imageUrl,
    description: description,
  );

  Product toEntity() => Product(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    discountPercent: discountPercent,
    imageUrl: imageUrl,
    description: description,
  );
}
