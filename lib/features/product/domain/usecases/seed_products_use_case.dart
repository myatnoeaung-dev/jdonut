import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class SeedProductsUseCase implements UseCase<void, NoParams> {
  const SeedProductsUseCase(this._repository);

  final ProductRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) => _repository.seedProductsIfEmpty();
}
