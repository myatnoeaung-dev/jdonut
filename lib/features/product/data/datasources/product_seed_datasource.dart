import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_seed_files.dart';
import '../../../../core/database/seed/json_asset_loader.dart';
import '../models/product_model.dart';

/// Reads the product catalogue bundled under `assets/seed/`.
abstract interface class ProductSeedDatasource {
  Future<List<ProductModel>> loadSeedProducts();
}

@LazySingleton(as: ProductSeedDatasource)
class ProductSeedDatasourceImpl implements ProductSeedDatasource {
  const ProductSeedDatasourceImpl(this._loader);

  final JsonAssetLoader _loader;

  @override
  Future<List<ProductModel>> loadSeedProducts() => _loader.load(AppSeedFiles.products, ProductModel.listFromJson);
}
