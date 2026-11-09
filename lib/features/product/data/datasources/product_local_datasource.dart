import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_guard.dart';
import '../../../../core/error/failure.dart';
import '../models/product_model.dart';

abstract interface class ProductLocalDatasource {
  Stream<List<ProductModel>> watchProducts();

  /// Throws [NotFoundFailure] when no product has [id].
  Future<ProductModel> getProductById(String id);

  /// Live product; the stream errors with [NotFoundFailure] while no product has [id].
  Stream<ProductModel> watchProductById(String id);

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
  Future<ProductModel> getProductById(String id) => guardLocal(() async {
    final query = _database.select(_database.products)..where((table) => table.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) throw NotFoundFailure('Product not found', 'No product with id "$id"');
    return ProductModel.fromRow(row);
  });

  @override
  Stream<ProductModel> watchProductById(String id) {
    final query = _database.select(_database.products)..where((table) => table.id.equals(id));
    return query.watchSingleOrNull().map((row) {
      if (row == null) throw NotFoundFailure('Product not found', 'No product with id "$id"');
      return ProductModel.fromRow(row);
    });
  }

  @override
  Future<bool> hasProducts() => guardLocal(() async {
    final count = _database.products.id.count();
    final query = _database.selectOnly(_database.products)..addColumns([count]);
    final row = await query.getSingle();
    return (row.read(count) ?? 0) > 0;
  });

  @override
  Future<void> upsertProducts(List<ProductModel> products) => guardLocal(
    () => _database.batch(
      (batch) => batch.insertAllOnConflictUpdate(_database.products, products.map((product) => product.toCompanion())),
    ),
  );
}
