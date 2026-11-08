import '../../../../core/error/result.dart';
import '../entities/product.dart';

abstract interface class ProductRepository {
  /// Live list from the local database; re-emits whenever products change.
  Stream<Result<List<Product>>> watchProducts();

  /// Fails with `NotFoundFailure` when [id] isn't in the local database.
  Future<Result<Product>> getProductById(String id);

  /// Loads the bundled seed catalogue on first run; does nothing if products exist.
  Future<Result<void>> seedProductsIfEmpty();
}
