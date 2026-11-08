import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failure.dart';
import '../models/product_model.dart';

abstract interface class ProductLocalDatasource {
  Stream<List<ProductModel>> watchProducts();

  /// Throws [NotFoundFailure] when no product has [id].
  Future<ProductModel> getProductById(String id);

  Future<bool> hasProducts();

  Future<void> upsertProducts(List<ProductModel> products);
}

@LazySingleton(as: ProductLocalDatasource)
class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  const ProductLocalDatasourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<List<ProductModel>> watchProducts() {
    final query = _database.select(_database.products)..orderBy([(table) => OrderingTerm.asc(table.code)]);
    return query.watch().map((rows) => rows.map(ProductModel.fromRow).toList());
  }

  @override
  Future<ProductModel> getProductById(String id) => _guard(() async {
        final query = _database.select(_database.products)..where((table) => table.id.equals(id));
        final row = await query.getSingleOrNull();
        if (row == null) throw NotFoundFailure('Product not found', 'No product with id "$id"');
        return ProductModel.fromRow(row);
      });

  @override
  Future<bool> hasProducts() => _guard(() async {
        final count = _database.products.id.count();
        final query = _database.selectOnly(_database.products)..addColumns([count]);
        final row = await query.getSingle();
        return (row.read(count) ?? 0) > 0;
      });

  @override
  Future<void> upsertProducts(List<ProductModel> products) => _guard(
        () => _database.batch(
          (batch) => batch.insertAllOnConflictUpdate(
            _database.products,
            products.map((product) => product.toCompanion()),
          ),
        ),
      );

  /// Maps database exceptions to [CacheFailure]; [Failure]s pass through unchanged.
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on Failure {
      rethrow;
    } on Exception catch (error) {
      throw CacheFailure('Local database error', '$error');
    }
  }
}
