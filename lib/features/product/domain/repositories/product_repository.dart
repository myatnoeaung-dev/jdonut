import 'package:fpdart/fpdart.dart';

import '../../../../core/error/result.dart';
import '../entities/product.dart';

abstract interface class ProductRepository {
  /// Live list from the local database; re-emits whenever products change.
  Stream<Result<List<Product>>> watchProducts();

  /// Live product from the local database; a `NotFoundFailure` while [id] isn't there.
  Stream<Result<Product>> watchProductById(String id);

  /// Fails with `NotFoundFailure` when [id] isn't in the local database.
  Future<Result<Product>> getProductById(String id);

  /// Loads the bundled seed catalogue on first run; does nothing if products exist.
  Future<Result<void>> seedProductsIfEmpty();

  /// Saves the server's catalogue locally. Being offline is not a failure.
  Future<Result<Unit>> refreshProducts();
}
