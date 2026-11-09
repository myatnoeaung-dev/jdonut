import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../error/dio_exception.dart';
import '../error/failure.dart';
import '../models/api_envelope.dart';

/// Thin wrapper over Dio that unwraps the `/v1` envelope and throws typed [Failure]s.
@lazySingleton
class ApiClient {
  const ApiClient(this._dio);

  final Dio _dio;

  /// GETs [path] and returns the envelope's `data`, parsed by [parseData].
  Future<T> get<T>(String path, T Function(Object? json) parseData) async {
    final ApiEnvelope<T> envelope;
    try {
      final response = await _dio.get<Map<String, dynamic>>(path);
      envelope = ApiEnvelope.fromJson(response.data!, parseData);
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error).failure;
    } on TypeError catch (error) {
      throw ServerFailure('Unexpected response', '$path: $error');
    }
    return _unwrap(envelope, path);
  }

  T _unwrap<T>(ApiEnvelope<T> envelope, String path) {
    final error = envelope.error;
    if (error != null) throw ServerFailure(error.code, error.message);
    final data = envelope.data;
    if (data == null) throw ServerFailure('Empty response', 'No data in $path');
    return data;
  }
}
