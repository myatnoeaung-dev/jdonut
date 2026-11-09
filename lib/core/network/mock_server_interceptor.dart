import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/app_seed_files.dart';
import 'api_config.dart';

/// Stands in for the J'Donut API: answers `/v1` requests from the bundled JSON,
/// wrapped in the `{data, meta, error}` envelope, after a short delay.
/// Remove it from the Dio setup in `network_module.dart` to use a real server.
@lazySingleton
class MockServerInterceptor extends Interceptor {
  MockServerInterceptor(this._assets, @Named(ApiConfig.mockLatencyName) this._latency);

  final AssetBundle _assets;
  final Duration _latency;

  static const Map<String, String> _responses = {
    ApiPaths.home: AppSeedFiles.home,
    ApiPaths.products: AppSeedFiles.products,
    ApiPaths.currentMember: AppSeedFiles.member,
  };

  static const int _statusOk = 200;
  static const int _statusNotFound = 404;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_latency > Duration.zero) await Future<void>.delayed(_latency);
    final assetPath = _responses[options.path];
    if (assetPath == null) return handler.reject(_notFound(options));
    try {
      final data = jsonDecode(await _assets.loadString(assetPath));
      handler.resolve(_envelope(options, _statusOk, data: data));
    } on Exception catch (error) {
      handler.reject(DioException(requestOptions: options, error: error));
    }
  }

  DioException _notFound(RequestOptions options) => DioException.badResponse(
    statusCode: _statusNotFound,
    requestOptions: options,
    response: _envelope(
      options,
      _statusNotFound,
      error: {'code': 'not_found', 'message': 'No mock response for ${options.path}'},
    ),
  );

  Response<Map<String, dynamic>> _envelope(RequestOptions options, int statusCode, {Object? data, Object? error}) =>
      Response(
        requestOptions: options,
        statusCode: statusCode,
        data: {
          'data': data,
          'meta': {'source': 'mock'},
          'error': error,
        },
      );
}
