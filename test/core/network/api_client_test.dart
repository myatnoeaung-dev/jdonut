import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/network/api_client.dart';
import 'package:jdonut/core/network/api_config.dart';
import 'package:jdonut/core/network/mock_server_interceptor.dart';
import 'package:jdonut/features/home/data/models/home_content_model.dart';
import 'package:jdonut/features/product/data/models/product_model.dart';
import 'package:jdonut/features/rewards/data/models/member_model.dart';

import '../../helpers/fakes.dart';

/// Answers every request with [body], bypassing the mock server.
class _FixedResponse extends Interceptor {
  _FixedResponse(this.body);

  final Map<String, dynamic> body;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) =>
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: body));
}

ApiClient _clientWith(Interceptor interceptor) =>
    ApiClient(Dio(BaseOptions(baseUrl: ApiConfig.baseUrl))..interceptors.add(interceptor));

void main() {
  final mockServer = ApiClient(
    Dio(BaseOptions(baseUrl: ApiConfig.baseUrl))
      ..interceptors.add(MockServerInterceptor(FileAssetBundle(), Duration.zero)),
  );

  group('mock server', () {
    test('serves the product catalogue inside the /v1 envelope', () async {
      final products = await mockServer.get(ApiPaths.products, ProductModel.listFromJson);

      expect(products, isNotEmpty);
      expect(products.first.id, 'p_coconut');
    });

    test('serves Home content and the member record', () async {
      final home = await mockServer.get(ApiPaths.home, HomeContentModel.parse);
      final member = await mockServer.get(ApiPaths.currentMember, MemberModel.parse);

      expect(home.sections.map((section) => section.id), ['seasonal', 'popular', 'orderAgain']);
      expect(member.tier, 'silver');
    });

    test('throws a ServerFailure for an unknown path', () {
      expect(mockServer.get('/v1/unknown', (json) => json), throwsA(isA<ServerFailure>()));
    });
  });

  test('throws a ServerFailure when the envelope carries an error', () {
    final client = _clientWith(
      _FixedResponse({
        'data': null,
        'meta': <String, dynamic>{},
        'error': {'code': 'maintenance', 'message': 'Back soon'},
      }),
    );

    expect(
      client.get(ApiPaths.products, ProductModel.listFromJson),
      throwsA(const ServerFailure('maintenance', 'Back soon')),
    );
  });

  test('throws a ServerFailure when the data has an unexpected shape', () {
    final client = _clientWith(_FixedResponse({'data': 'not a list', 'meta': <String, dynamic>{}, 'error': null}));

    expect(client.get(ApiPaths.products, ProductModel.listFromJson), throwsA(isA<ServerFailure>()));
  });
}
