// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter/services.dart' as _i281;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/product/data/datasources/product_local_datasource.dart'
    as _i394;
import '../../features/product/data/datasources/product_seed_datasource.dart'
    as _i418;
import '../../features/product/data/repositories/product_repository_impl.dart'
    as _i1040;
import '../../features/product/domain/repositories/product_repository.dart'
    as _i39;
import '../../features/product/domain/usecases/get_product_by_id_use_case.dart'
    as _i503;
import '../../features/product/domain/usecases/seed_products_use_case.dart'
    as _i653;
import '../../features/product/domain/usecases/watch_products_use_case.dart'
    as _i153;
import '../database/app_database.dart' as _i982;
import '../network/network_info.dart' as _i932;
import '../session/auth_session.dart' as _i971;
import '../shared/storage_util.dart' as _i109;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final connectivityModule = _$ConnectivityModule();
  final storageModule = _$StorageModule();
  final assetBundleModule = _$AssetBundleModule();
  gh.lazySingleton<_i982.AppDatabase>(
    () => databaseModule.database,
    dispose: _i982.closeDatabase,
  );
  gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
  gh.lazySingleton<_i971.AuthSession>(() => _i971.AuthSession());
  gh.lazySingleton<_i558.FlutterSecureStorage>(
    () => storageModule.flutterSecureStorage,
  );
  gh.lazySingleton<_i281.AssetBundle>(() => assetBundleModule.assetBundle);
  gh.lazySingleton<_i418.ProductSeedDatasource>(
    () => _i418.ProductSeedDatasourceImpl(gh<_i281.AssetBundle>()),
  );
  gh.lazySingleton<_i932.NetworkInfo>(
    () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
  );
  gh.factory<_i109.StoregeUtil>(
    () => _i109.StoregeUtil(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i394.ProductLocalDatasource>(
    () => _i394.ProductLocalDatasourceImpl(gh<_i982.AppDatabase>()),
  );
  gh.lazySingleton<_i39.ProductRepository>(
    () => _i1040.ProductRepositoryImpl(
      gh<_i394.ProductLocalDatasource>(),
      gh<_i418.ProductSeedDatasource>(),
      networkInfo: gh<_i932.NetworkInfo>(),
    ),
  );
  gh.lazySingleton<_i503.GetProductByIdUseCase>(
    () => _i503.GetProductByIdUseCase(gh<_i39.ProductRepository>()),
  );
  gh.lazySingleton<_i653.SeedProductsUseCase>(
    () => _i653.SeedProductsUseCase(gh<_i39.ProductRepository>()),
  );
  gh.lazySingleton<_i153.WatchProductsUseCase>(
    () => _i153.WatchProductsUseCase(gh<_i39.ProductRepository>()),
  );
  return getIt;
}

class _$DatabaseModule extends _i982.DatabaseModule {}

class _$ConnectivityModule extends _i932.ConnectivityModule {}

class _$StorageModule extends _i109.StorageModule {}

class _$AssetBundleModule extends _i418.AssetBundleModule {}
