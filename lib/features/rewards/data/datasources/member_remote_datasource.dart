import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';
import '../models/member_model.dart';

abstract interface class MemberRemoteDatasource {
  /// Throws a `Failure` when the request fails.
  Future<MemberModel> fetchCurrentMember();
}

@LazySingleton(as: MemberRemoteDatasource)
class MemberRemoteDatasourceImpl implements MemberRemoteDatasource {
  const MemberRemoteDatasourceImpl(this._api);

  final ApiClient _api;

  @override
  Future<MemberModel> fetchCurrentMember() => _api.get(ApiPaths.currentMember, MemberModel.parse);
}
