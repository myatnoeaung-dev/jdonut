import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/network/network_info.dart';
import 'package:jdonut/features/product/data/datasources/product_local_datasource.dart';
import 'package:jdonut/features/product/data/datasources/product_remote_datasource.dart';
import 'package:jdonut/features/product/data/datasources/product_seed_datasource.dart';
import 'package:jdonut/features/product/data/models/product_model.dart';
import 'package:jdonut/features/product/data/repositories/product_repository_impl.dart';

class _MockLocal extends Mock implements ProductLocalDatasource {}

class _MockSeed extends Mock implements ProductSeedDatasource {}

class _MockRemote extends Mock implements ProductRemoteDatasource {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

const _coconut = ProductModel(
  id: 'p_coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  imageUrl: 'assets/images/products/p_coconut.png',
  description: 'Coconut',
);

void main() {
  late _MockLocal local;
  late _MockSeed seed;
  late _MockRemote remote;
  late _MockNetworkInfo networkInfo;
  late ProductRepositoryImpl repository;

  setUp(() {
    local = _MockLocal();
    seed = _MockSeed();
    remote = _MockRemote();
    networkInfo = _MockNetworkInfo();
    repository = ProductRepositoryImpl(local, seed, remote, networkInfo: networkInfo);
  });

  group('seedProductsIfEmpty', () {
    test('loads the seed file into the database when it is empty', () async {
      when(() => local.hasProducts()).thenAnswer((_) async => false);
      when(() => seed.loadSeedProducts()).thenAnswer((_) async => [_coconut]);
      when(() => local.upsertProducts(any())).thenAnswer((_) async {});

      final result = await repository.seedProductsIfEmpty();

      expect(result.isRight(), isTrue);
      verify(() => local.upsertProducts([_coconut])).called(1);
    });

    test('leaves existing products untouched', () async {
      when(() => local.hasProducts()).thenAnswer((_) async => true);

      await repository.seedProductsIfEmpty();

      verifyNever(() => seed.loadSeedProducts());
    });

    test('returns the failure when the seed file cannot be read', () async {
      const failure = CacheFailure('Seed data error', 'bad json');
      when(() => local.hasProducts()).thenAnswer((_) async => false);
      when(() => seed.loadSeedProducts()).thenThrow(failure);

      final result = await repository.seedProductsIfEmpty();

      expect(result.getLeft().toNullable(), failure);
    });
  });

  test('getProductById returns NotFoundFailure as a Left', () async {
    when(() => local.getProductById('missing')).thenThrow(const NotFoundFailure('Not found', null));

    final result = await repository.getProductById('missing');

    expect(result.getLeft().toNullable(), isA<NotFoundFailure>());
  });

  test('watchProducts maps models to entities', () async {
    when(() => local.watchProducts()).thenAnswer((_) => Stream.value([_coconut]));

    final result = await repository.watchProducts().first;

    expect(result.getRight().toNullable()?.single.name, 'Coconut Donut');
  });

  test('watchProducts turns a database error into a Left', () async {
    when(() => local.watchProducts()).thenAnswer((_) => Stream.error(Exception('disk full')));

    final result = await repository.watchProducts().first;

    expect(result.getLeft().toNullable(), isA<CacheFailure>());
  });

  test('watchProductById turns a missing product into a NotFoundFailure', () async {
    when(() => local.watchProductById('missing'))
        .thenAnswer((_) => Stream.error(const NotFoundFailure('Product not found', null)));

    final result = await repository.watchProductById('missing').first;

    expect(result.getLeft().toNullable(), isA<NotFoundFailure>());
  });

  group('refreshProducts', () {
    test('does nothing and succeeds while offline', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.refreshProducts();

      expect(result.isRight(), isTrue);
      verifyNever(() => remote.fetchProducts());
    });

    test('saves the server catalogue locally when online', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchProducts()).thenAnswer((_) async => [_coconut]);
      when(() => local.upsertProducts(any())).thenAnswer((_) async {});

      final result = await repository.refreshProducts();

      expect(result.isRight(), isTrue);
      verify(() => local.upsertProducts([_coconut])).called(1);
    });

    test('returns the server failure and keeps local data when the request fails', () async {
      const failure = ServerFailure('500', 'Server down');
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchProducts()).thenThrow(failure);

      final result = await repository.refreshProducts();

      expect(result.getLeft().toNullable(), failure);
      verifyNever(() => local.upsertProducts(any()));
    });
  });
}
