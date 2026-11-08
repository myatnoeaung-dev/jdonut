import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';
import '../error/result.dart';
import '../network/network_info.dart';

/// Offline-first helpers: the UI watches the local database, and remote data
/// only refreshes it.
abstract class BaseRepository {
  const BaseRepository({required this.networkInfo});

  final NetworkInfo networkInfo;

  /// Runs [call] and turns a thrown [Failure] (or unexpected exception) into a [Left].
  Future<Result<T>> guard<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } on Failure catch (failure) {
      return Left(failure);
    } on Exception catch (error) {
      return Left(UnknownFailure('Unexpected error', '$error'));
    }
  }

  /// Wraps a local database stream so errors arrive as [Left] values.
  Stream<Result<T>> guardStream<T>(Stream<T> source) {
    return source.transform(
      StreamTransformer<T, Result<T>>.fromHandlers(
        handleData: (data, sink) => sink.add(Right(data)),
        handleError: (error, _, sink) => sink.add(Left(_toFailure(error))),
      ),
    );
  }

  /// Fetches remote data and saves it locally. Being offline is not an error:
  /// the UI keeps showing what is already in the database.
  Future<Result<Unit>> refreshWhenOnline<T>({
    required Future<T> Function() fetchRemote,
    required Future<void> Function(T data) saveLocal,
  }) async {
    if (!await networkInfo.isConnected) return const Right(unit);
    return guard(() async {
      await saveLocal(await fetchRemote());
      return unit;
    });
  }

  Failure _toFailure(Object error) => error is Failure ? error : CacheFailure('Local data error', '$error');
}
