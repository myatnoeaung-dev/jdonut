import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Live product for `/product/:id`, so a background refresh updates the open page.
@lazySingleton
class WatchProductByIdUseCase implements StreamUseCase<Product, String> {
  const WatchProductByIdUseCase(this._repository);

  final ProductRepository _repository;

  @override
  Stream<Result<Product>> call(String productId) => _repository.watchProductById(productId);
}
