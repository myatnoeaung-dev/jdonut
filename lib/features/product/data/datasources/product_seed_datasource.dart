import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_seed_files.dart';
import '../../../../core/error/failure.dart';
import '../models/product_model.dart';

/// Reads the product catalogue bundled under `assets/seed/`.
abstract interface class ProductSeedDatasource {
  Future<List<ProductModel>> loadSeedProducts();
}

@LazySingleton(as: ProductSeedDatasource)
class ProductSeedDatasourceImpl implements ProductSeedDatasource {
  const ProductSeedDatasourceImpl(this._assetBundle);

  final AssetBundle _assetBundle;

  @override
  Future<List<ProductModel>> loadSeedProducts() async {
    try {
      final raw = await _assetBundle.loadString(AppSeedFiles.products);
      final items = jsonDecode(raw) as List<dynamic>;
      return items.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
    } on Exception catch (error) {
      throw CacheFailure('Seed data error', 'Could not read ${AppSeedFiles.products}: $error');
    } on TypeError catch (error) {
      throw CacheFailure('Seed data error', 'Unexpected shape in ${AppSeedFiles.products}: $error');
    }
  }
}

@module
abstract class AssetBundleModule {
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;
}
