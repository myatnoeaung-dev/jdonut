import '../error/result.dart';

abstract class UseCase<R, Params> {
  Future<Result<R>> call(Params params);
}

abstract class StreamUseCase<R, Params> {
  Stream<Result<R>> call(Params params);
}

class NoParams {
  const NoParams();
}
