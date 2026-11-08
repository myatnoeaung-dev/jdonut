import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductByIdUseCase implements UseCase<Product, String> {
  const GetProductByIdUseCase(this._repository);

  final ProductRepository _repository;

  @override
  Future<Result<Product>> call(String productId) => _repository.getProductById(productId);
}
