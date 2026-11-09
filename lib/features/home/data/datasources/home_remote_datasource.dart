import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';
import '../models/home_content_model.dart';

/// Home content from the API. Only the repository uses it, to refresh the local database.
abstract interface class HomeRemoteDatasource {
  /// Throws a `Failure` when the request fails.
  Future<HomeContentModel> fetchHomeContent();
}

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  const HomeRemoteDatasourceImpl(this._api);

  final ApiClient _api;

  @override
  Future<HomeContentModel> fetchHomeContent() => _api.get(ApiPaths.home, HomeContentModel.parse);
}
