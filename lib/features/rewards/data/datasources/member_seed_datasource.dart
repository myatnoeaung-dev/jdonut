import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_seed_files.dart';
import '../../../../core/database/seed/json_asset_loader.dart';
import '../models/member_model.dart';

abstract interface class MemberSeedDatasource {
  Future<MemberModel> loadSeedMember();
}

@LazySingleton(as: MemberSeedDatasource)
class MemberSeedDatasourceImpl implements MemberSeedDatasource {
  const MemberSeedDatasourceImpl(this._loader);

  final JsonAssetLoader _loader;

  @override
  Future<MemberModel> loadSeedMember() => _loader.load(AppSeedFiles.member, MemberModel.parse);
}
