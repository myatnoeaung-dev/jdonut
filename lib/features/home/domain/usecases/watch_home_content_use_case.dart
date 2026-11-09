import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/home_content.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class WatchHomeContentUseCase implements StreamUseCase<HomeContent, NoParams> {
  const WatchHomeContentUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Stream<Result<HomeContent>> call(NoParams params) => _repository.watchHomeContent();
}
