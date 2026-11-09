import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';
import '../models/product_model.dart';

/// The product catalogue from the API. Only the repository uses it, to refresh the local database.
abstract interface class ProductRemoteDatasource {
  /// Throws a `Failure` when the request fails.
  Future<List<ProductModel>> fetchProducts();
}

@LazySingleton(as: ProductRemoteDatasource)
class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  const ProductRemoteDatasourceImpl(this._api);

  final ApiClient _api;

  @override
  Future<List<ProductModel>> fetchProducts() => _api.get(ApiPaths.products, ProductModel.listFromJson);
}
