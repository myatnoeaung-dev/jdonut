import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class WatchProductsUseCase implements StreamUseCase<List<Product>, NoParams> {
  const WatchProductsUseCase(this._repository);

  final ProductRepository _repository;

  @override
  Stream<Result<List<Product>>> call(NoParams params) => _repository.watchProducts();
}
