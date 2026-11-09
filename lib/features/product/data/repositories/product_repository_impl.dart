import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/repositories/base_repostitory.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../datasources/product_seed_datasource.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends BaseRepository implements ProductRepository {
  const ProductRepositoryImpl(this._local, this._seed, this._remote, {required super.networkInfo});

  final ProductLocalDatasource _local;
  final ProductSeedDatasource _seed;
  final ProductRemoteDatasource _remote;

  @override
  Stream<Result<List<Product>>> watchProducts() =>
      guardStream(_local.watchProducts().map((models) => models.map((model) => model.toEntity()).toList()));

  @override
  Stream<Result<Product>> watchProductById(String id) =>
      guardStream(_local.watchProductById(id).map((model) => model.toEntity()));

  @override
  Future<Result<Product>> getProductById(String id) => guard(() async => (await _local.getProductById(id)).toEntity());

  @override
  Future<Result<void>> seedProductsIfEmpty() => guard(() async {
    if (await _local.hasProducts()) return;
    await _local.upsertProducts(await _seed.loadSeedProducts());
  });

  @override
  Future<Result<Unit>> refreshProducts() =>
      refreshWhenOnline(fetchRemote: _remote.fetchProducts, saveLocal: _local.upsertProducts);
}
