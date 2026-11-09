import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_config.dart';
import 'mock_server_interceptor.dart';

@module
abstract class NetworkModule {
  @Named(ApiConfig.mockLatencyName)
  Duration get mockServerLatency => ApiConfig.mockLatency;

  @lazySingleton
  Dio dio(MockServerInterceptor mockServer) => Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
    ),
  )..interceptors.add(mockServer);
}
