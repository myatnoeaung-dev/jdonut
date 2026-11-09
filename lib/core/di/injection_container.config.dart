// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/auth_config.dart' as _i106;
import '../../features/auth/data/datasources/auth_local_datasource.dart'
    as _i992;
import '../../features/auth/data/repositories/fake_auth_repository_impl.dart'
    as _i587;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_phone_registered_use_case.dart'
    as _i695;
import '../../features/auth/domain/usecases/log_out_use_case.dart' as _i105;
import '../../features/auth/domain/usecases/register_user_use_case.dart'
    as _i468;
import '../../features/auth/domain/usecases/restore_session_use_case.dart'
    as _i585;
import '../../features/auth/domain/usecases/send_otp_use_case.dart' as _i643;
import '../../features/auth/domain/usecases/verify_otp_use_case.dart' as _i509;
import '../../features/auth/domain/usecases/watch_session_use_case.dart'
    as _i11;
import '../../features/auth/presentation/bloc/auth/auth_bloc.dart' as _i469;
import '../../features/auth/presentation/bloc/otp/otp_bloc.dart' as _i75;
import '../../features/auth/presentation/bloc/phone/phone_bloc.dart' as _i258;
import '../../features/auth/presentation/bloc/profile/profile_bloc.dart'
    as _i228;
import '../../features/home/data/datasources/home_local_datasource.dart'
    as _i314;
import '../../features/home/data/datasources/home_remote_datasource.dart'
    as _i278;
import '../../features/home/data/datasources/home_seed_datasource.dart' as _i49;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/usecases/refresh_home_content_use_case.dart'
    as _i862;
import '../../features/home/domain/usecases/seed_local_database_use_case.dart'
    as _i137;
import '../../features/home/domain/usecases/watch_home_content_use_case.dart'
    as _i914;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/product/data/datasources/product_local_datasource.dart'
    as _i394;
import '../../features/product/data/datasources/product_remote_datasource.dart'
    as _i963;
import '../../features/product/data/datasources/product_seed_datasource.dart'
    as _i418;
import '../../features/product/data/repositories/product_repository_impl.dart'
    as _i1040;
import '../../features/product/domain/repositories/product_repository.dart'
    as _i39;
import '../../features/product/domain/usecases/get_product_by_id_use_case.dart'
    as _i503;
import '../../features/product/domain/usecases/watch_product_by_id_use_case.dart'
    as _i942;
import '../../features/product/domain/usecases/watch_products_use_case.dart'
    as _i153;
import '../../features/product/presentation/bloc/product_detail_bloc.dart'
    as _i1052;
import '../../features/rewards/data/datasources/member_local_datasource.dart'
    as _i20;
import '../../features/rewards/data/datasources/member_remote_datasource.dart'
    as _i684;
import '../../features/rewards/data/datasources/member_seed_datasource.dart'
    as _i162;
import '../../features/rewards/data/repositories/member_repository_impl.dart'
    as _i453;
import '../../features/rewards/domain/repositories/member_repository.dart'
    as _i543;
import '../../features/rewards/domain/usecases/watch_current_member_use_case.dart'
    as _i462;
import '../../features/rewards/presentation/bloc/member/member_bloc.dart'
    as _i173;
import '../database/app_database.dart' as _i982;
import '../database/seed/json_asset_loader.dart' as _i883;
import '../l10n/locale_controller.dart' as _i984;
import '../network/api_client.dart' as _i557;
import '../network/connectivity_cubit.dart' as _i838;
import '../network/mock_server_interceptor.dart' as _i101;
import '../network/network_info.dart' as _i932;
import '../network/network_module.dart' as _i200;
import '../storage/session_storage.dart' as _i566;
import '../time/clock.dart' as _i807;
import '../time/countdown_ticker.dart' as _i58;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final databaseModule = _$DatabaseModule();
  final assetBundleModule = _$AssetBundleModule();
  final connectivityModule = _$ConnectivityModule();
  final storageModule = _$StorageModule();
  final authDataModule = _$AuthDataModule();
  final networkModule = _$NetworkModule();
  gh.lazySingleton<_i982.AppDatabase>(
    () => databaseModule.database,
    dispose: _i982.closeDatabase,
  );
  gh.lazySingleton<_i281.AssetBundle>(() => assetBundleModule.assetBundle);
  gh.lazySingleton<_i984.LocaleController>(() => _i984.LocaleController());
  gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
  gh.lazySingleton<_i558.FlutterSecureStorage>(
    () => storageModule.flutterSecureStorage,
  );
  gh.lazySingleton<_i807.Clock>(() => const _i807.SystemClock());
  gh.factory<Duration>(
    () => authDataModule.fakeAuthLatency,
    instanceName: 'fakeAuthLatency',
  );
  gh.factory<Duration>(
    () => networkModule.mockServerLatency,
    instanceName: 'mockServerLatency',
  );
  gh.lazySingleton<_i58.CountdownTicker>(
    () => const _i58.PeriodicCountdownTicker(),
  );
  gh.lazySingleton<_i566.SessionStorage>(
    () => _i566.SecureSessionStorage(gh<_i558.FlutterSecureStorage>()),
  );
  gh.lazySingleton<_i883.JsonAssetLoader>(
    () => _i883.JsonAssetLoader(gh<_i281.AssetBundle>()),
  );
  gh.lazySingleton<_i932.NetworkInfo>(
    () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
  );
  gh.lazySingleton<_i992.AuthLocalDatasource>(
    () => _i992.AuthLocalDatasourceImpl(gh<_i982.AppDatabase>()),
  );
  gh.lazySingleton<_i20.MemberLocalDatasource>(
    () => _i20.MemberLocalDatasourceImpl(gh<_i982.AppDatabase>()),
  );
  gh.lazySingleton<_i101.MockServerInterceptor>(
    () => _i101.MockServerInterceptor(
      gh<_i281.AssetBundle>(),
      gh<Duration>(instanceName: 'mockServerLatency'),
    ),
  );
  gh.lazySingleton<_i361.Dio>(
    () => networkModule.dio(gh<_i101.MockServerInterceptor>()),
  );
  gh.lazySingleton<_i314.HomeLocalDatasource>(
    () => _i314.HomeLocalDatasourceImpl(gh<_i982.AppDatabase>()),
  );
  gh.lazySingleton<_i394.ProductLocalDatasource>(
    () => _i394.ProductLocalDatasourceImpl(gh<_i982.AppDatabase>()),
  );
  gh.lazySingleton<_i418.ProductSeedDatasource>(
    () => _i418.ProductSeedDatasourceImpl(gh<_i883.JsonAssetLoader>()),
  );
  gh.lazySingleton<_i838.ConnectivityCubit>(
    () => _i838.ConnectivityCubit(gh<_i932.NetworkInfo>()),
  );
  gh.lazySingleton<_i162.MemberSeedDatasource>(
    () => _i162.MemberSeedDatasourceImpl(gh<_i883.JsonAssetLoader>()),
  );
  gh.lazySingleton<_i787.AuthRepository>(
    () => _i587.FakeAuthRepositoryImpl(
      gh<_i992.AuthLocalDatasource>(),
      gh<_i566.SessionStorage>(),
      gh<Duration>(instanceName: 'fakeAuthLatency'),
      networkInfo: gh<_i932.NetworkInfo>(),
    ),
  );
  gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient(gh<_i361.Dio>()));
  gh.lazySingleton<_i49.HomeSeedDatasource>(
    () => _i49.HomeSeedDatasourceImpl(gh<_i883.JsonAssetLoader>()),
  );
  gh.lazySingleton<_i695.CheckPhoneRegisteredUseCase>(
    () => _i695.CheckPhoneRegisteredUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i105.LogOutUseCase>(
    () => _i105.LogOutUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i468.RegisterUserUseCase>(
    () => _i468.RegisterUserUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i585.RestoreSessionUseCase>(
    () => _i585.RestoreSessionUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i643.SendOtpUseCase>(
    () => _i643.SendOtpUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i509.VerifyOtpUseCase>(
    () => _i509.VerifyOtpUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i11.WatchSessionUseCase>(
    () => _i11.WatchSessionUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i258.PhoneBloc>(
    () => _i258.PhoneBloc(
      gh<_i695.CheckPhoneRegisteredUseCase>(),
      gh<_i643.SendOtpUseCase>(),
    ),
  );
  gh.lazySingleton<_i963.ProductRemoteDatasource>(
    () => _i963.ProductRemoteDatasourceImpl(gh<_i557.ApiClient>()),
  );
  gh.lazySingleton<_i684.MemberRemoteDatasource>(
    () => _i684.MemberRemoteDatasourceImpl(gh<_i557.ApiClient>()),
  );
  gh.lazySingleton<_i469.AuthBloc>(
    () => _i469.AuthBloc(
      gh<_i585.RestoreSessionUseCase>(),
      gh<_i105.LogOutUseCase>(),
      gh<_i11.WatchSessionUseCase>(),
    ),
  );
  gh.lazySingleton<_i278.HomeRemoteDatasource>(
    () => _i278.HomeRemoteDatasourceImpl(gh<_i557.ApiClient>()),
  );
  gh.lazySingleton<_i39.ProductRepository>(
    () => _i1040.ProductRepositoryImpl(
      gh<_i394.ProductLocalDatasource>(),
      gh<_i418.ProductSeedDatasource>(),
      gh<_i963.ProductRemoteDatasource>(),
      networkInfo: gh<_i932.NetworkInfo>(),
    ),
  );
  gh.factory<_i75.OtpBloc>(
    () => _i75.OtpBloc(
      gh<_i509.VerifyOtpUseCase>(),
      gh<_i643.SendOtpUseCase>(),
      gh<_i58.CountdownTicker>(),
    ),
  );
  gh.factory<_i228.ProfileBloc>(
    () => _i228.ProfileBloc(gh<_i468.RegisterUserUseCase>(), gh<_i807.Clock>()),
  );
  gh.lazySingleton<_i0.HomeRepository>(
    () => _i76.HomeRepositoryImpl(
      gh<_i314.HomeLocalDatasource>(),
      gh<_i49.HomeSeedDatasource>(),
      gh<_i278.HomeRemoteDatasource>(),
      networkInfo: gh<_i932.NetworkInfo>(),
    ),
  );
  gh.lazySingleton<_i503.GetProductByIdUseCase>(
    () => _i503.GetProductByIdUseCase(gh<_i39.ProductRepository>()),
  );
  gh.lazySingleton<_i942.WatchProductByIdUseCase>(
    () => _i942.WatchProductByIdUseCase(gh<_i39.ProductRepository>()),
  );
  gh.lazySingleton<_i153.WatchProductsUseCase>(
    () => _i153.WatchProductsUseCase(gh<_i39.ProductRepository>()),
  );
  gh.lazySingleton<_i543.MemberRepository>(
    () => _i453.MemberRepositoryImpl(
      gh<_i20.MemberLocalDatasource>(),
      gh<_i162.MemberSeedDatasource>(),
      gh<_i684.MemberRemoteDatasource>(),
      networkInfo: gh<_i932.NetworkInfo>(),
    ),
  );
  gh.lazySingleton<_i462.WatchCurrentMemberUseCase>(
    () => _i462.WatchCurrentMemberUseCase(gh<_i543.MemberRepository>()),
  );
  gh.lazySingleton<_i914.WatchHomeContentUseCase>(
    () => _i914.WatchHomeContentUseCase(gh<_i0.HomeRepository>()),
  );
  gh.lazySingleton<_i862.RefreshHomeContentUseCase>(
    () => _i862.RefreshHomeContentUseCase(
      gh<_i39.ProductRepository>(),
      gh<_i0.HomeRepository>(),
      gh<_i543.MemberRepository>(),
    ),
  );
  gh.lazySingleton<_i137.SeedLocalDatabaseUseCase>(
    () => _i137.SeedLocalDatabaseUseCase(
      gh<_i39.ProductRepository>(),
      gh<_i0.HomeRepository>(),
      gh<_i543.MemberRepository>(),
    ),
  );
  gh.factory<_i1052.ProductDetailBloc>(
    () => _i1052.ProductDetailBloc(gh<_i942.WatchProductByIdUseCase>()),
  );
  gh.factory<_i173.MemberBloc>(
    () => _i173.MemberBloc(gh<_i462.WatchCurrentMemberUseCase>()),
  );
  gh.factory<_i202.HomeBloc>(
    () => _i202.HomeBloc(
      gh<_i914.WatchHomeContentUseCase>(),
      gh<_i862.RefreshHomeContentUseCase>(),
    ),
  );
  return getIt;
}

class _$DatabaseModule extends _i982.DatabaseModule {}

class _$AssetBundleModule extends _i883.AssetBundleModule {}

class _$ConnectivityModule extends _i932.ConnectivityModule {}

class _$StorageModule extends _i566.StorageModule {}

class _$AuthDataModule extends _i106.AuthDataModule {}

class _$NetworkModule extends _i200.NetworkModule {}
