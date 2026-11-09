import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/repositories/base_repostitory.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';
import '../datasources/home_seed_datasource.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends BaseRepository implements HomeRepository {
  const HomeRepositoryImpl(this._local, this._seed, this._remote, {required super.networkInfo});

  final HomeLocalDatasource _local;
  final HomeSeedDatasource _seed;
  final HomeRemoteDatasource _remote;

  @override
  Stream<Result<HomeContent>> watchHomeContent() => guardStream(_local.watchHome().map(_toEntity));

  @override
  Future<Result<Unit>> seedHomeContentIfEmpty() => guard(() async {
    if (!await _local.hasHomeContent()) await _local.replaceHomeContent(await _seed.loadSeedHomeContent());
    return unit;
  });

  @override
  Future<Result<Unit>> refreshHomeContent() =>
      refreshWhenOnline(fetchRemote: _remote.fetchHomeContent, saveLocal: _local.replaceHomeContent);

  HomeContent _toEntity(HomeSnapshot snapshot) => HomeContent(
    banners: snapshot.banners.map((banner) => banner.toEntity()).toList(),
    sections: [
      for (final type in HomeSectionType.values)
        if (snapshot.sectionProducts[type.name] case final products? when products.isNotEmpty)
          HomeSection(type: type, products: products.map((product) => product.toEntity()).toList()),
    ],
    shops: snapshot.shops.map((shop) => shop.toEntity()).toList(),
  );
}
