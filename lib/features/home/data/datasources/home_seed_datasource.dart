import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_seed_files.dart';
import '../../../../core/database/seed/json_asset_loader.dart';
import '../models/home_content_model.dart';

abstract interface class HomeSeedDatasource {
  Future<HomeContentModel> loadSeedHomeContent();
}

@LazySingleton(as: HomeSeedDatasource)
class HomeSeedDatasourceImpl implements HomeSeedDatasource {
  const HomeSeedDatasourceImpl(this._loader);

  final JsonAssetLoader _loader;

  @override
  Future<HomeContentModel> loadSeedHomeContent() => _loader.load(AppSeedFiles.home, HomeContentModel.parse);
}
