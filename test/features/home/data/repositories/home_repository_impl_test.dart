import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/network/network_info.dart';
import 'package:jdonut/features/home/data/datasources/home_local_datasource.dart';
import 'package:jdonut/features/home/data/datasources/home_remote_datasource.dart';
import 'package:jdonut/features/home/data/datasources/home_seed_datasource.dart';
import 'package:jdonut/features/home/data/models/home_content_model.dart';
import 'package:jdonut/features/home/data/repositories/home_repository_impl.dart';
import 'package:jdonut/features/home/domain/entities/home_content.dart';
import 'package:jdonut/features/product/data/models/product_model.dart';

class _MockLocal extends Mock implements HomeLocalDatasource {}

class _MockSeed extends Mock implements HomeSeedDatasource {}

class _MockRemote extends Mock implements HomeRemoteDatasource {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

const _coconut = ProductModel(
  id: 'p_coconut',
  code: 'JD1',
  name: 'Coconut Donut',
  priceMmk: 3200,
  imageUrl: 'assets/c.png',
  description: 'Coconut',
);

const _content = HomeContentModel(
  sections: [
    HomeSectionModel(id: 'seasonal', productIds: ['p_coconut']),
  ],
);

void main() {
  late _MockLocal local;
  late _MockSeed seed;
  late _MockRemote remote;
  late _MockNetworkInfo networkInfo;
  late HomeRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(const HomeContentModel()));

  setUp(() {
    local = _MockLocal();
    seed = _MockSeed();
    remote = _MockRemote();
    networkInfo = _MockNetworkInfo();
    repository = HomeRepositoryImpl(local, seed, remote, networkInfo: networkInfo);
    when(() => local.replaceHomeContent(any())).thenAnswer((_) async {});
  });

  group('watchHomeContent', () {
    test('lists sections in display order and skips unknown or empty ones', () async {
      when(() => local.watchHome()).thenAnswer(
        (_) => Stream.value((
          banners: const <BannerModel>[],
          sectionProducts: const {
            'orderAgain': [_coconut],
            'retired': [_coconut],
            'popular': <ProductModel>[],
            'seasonal': [_coconut],
          },
          shops: const <ShopModel>[],
        )),
      );

      final content = (await repository.watchHomeContent().first).getRight().toNullable()!;

      expect(content.sections.map((section) => section.type), [HomeSectionType.seasonal, HomeSectionType.orderAgain]);
      expect(content.sections.first.products.single.name, 'Coconut Donut');
    });

    test('turns a database error into a CacheFailure', () async {
      when(() => local.watchHome()).thenAnswer((_) => Stream.error(Exception('disk full')));

      final result = await repository.watchHomeContent().first;

      expect(result.getLeft().toNullable(), isA<CacheFailure>());
    });
  });

  group('seedHomeContentIfEmpty', () {
    test('saves the bundled content on first launch', () async {
      when(() => local.hasHomeContent()).thenAnswer((_) async => false);
      when(() => seed.loadSeedHomeContent()).thenAnswer((_) async => _content);

      final result = await repository.seedHomeContentIfEmpty();

      expect(result.isRight(), isTrue);
      verify(() => local.replaceHomeContent(_content)).called(1);
    });

    test('leaves existing content untouched', () async {
      when(() => local.hasHomeContent()).thenAnswer((_) async => true);

      await repository.seedHomeContentIfEmpty();

      verifyNever(() => seed.loadSeedHomeContent());
    });
  });

  group('refreshHomeContent', () {
    test('succeeds without a request while offline', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.refreshHomeContent();

      expect(result.isRight(), isTrue);
      verifyNever(() => remote.fetchHomeContent());
    });

    test('replaces local content with the server content when online', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchHomeContent()).thenAnswer((_) async => _content);

      final result = await repository.refreshHomeContent();

      expect(result.isRight(), isTrue);
      verify(() => local.replaceHomeContent(_content)).called(1);
    });

    test('returns the failure and keeps saved content when the request fails', () async {
      const failure = ConnectionFailure('Check network connections', 'timeout');
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchHomeContent()).thenThrow(failure);

      final result = await repository.refreshHomeContent();

      expect(result.getLeft().toNullable(), failure);
      verifyNever(() => local.replaceHomeContent(any()));
    });
  });
}
