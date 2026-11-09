import '../error/failure.dart';

/// Runs a local database [action], turning database exceptions into a
/// [CacheFailure]. [Failure]s thrown on purpose pass through unchanged.
Future<T> guardLocal<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on Failure {
    rethrow;
  } on Exception catch (error) {
    throw CacheFailure('Local database error', '$error');
  }
}
