import 'package:flutter_test/flutter_test.dart';

import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/usecase/usecase.dart';
import 'package:jdonut/features/home/domain/entities/home_content.dart';
import 'package:jdonut/features/home/domain/repositories/home_repository.dart';
import 'package:jdonut/features/home/domain/usecases/refresh_home_content_use_case.dart';
import 'package:jdonut/features/home/domain/usecases/seed_local_database_use_case.dart';
import 'package:jdonut/features/home/domain/usecases/watch_home_content_use_case.dart';
import 'package:jdonut/features/product/domain/repositories/product_repository.dart';
import 'package:jdonut/features/rewards/domain/repositories/member_repository.dart';

class _MockProducts extends Mock implements ProductRepository {}

class _MockHome extends Mock implements HomeRepository {}

class _MockMember extends Mock implements MemberRepository {}

const _offline = ConnectionFailure('Check network connections', 'timeout');
const _emptyContent = HomeContent(banners: [], sections: [], shops: []);

void main() {
  late _MockProducts products;
  late _MockHome home;
  late _MockMember member;

  setUp(() {
    products = _MockProducts();
    home = _MockHome();
    member = _MockMember();
  });

  test('WatchHomeContentUseCase emits the repository content', () {
    when(() => home.watchHomeContent()).thenAnswer((_) => Stream.value(const Right(_emptyContent)));

    expect(WatchHomeContentUseCase(home)(const NoParams()), emits(const Right<Failure, HomeContent>(_emptyContent)));
  });

  group('RefreshHomeContentUseCase', () {
    late RefreshHomeContentUseCase refresh;

    setUp(() => refresh = RefreshHomeContentUseCase(products, home, member));

    test('refreshes products, then Home content, then the member record', () async {
      when(() => products.refreshProducts()).thenAnswer((_) async => const Right(unit));
      when(() => home.refreshHomeContent()).thenAnswer((_) async => const Right(unit));
      when(() => member.refreshMember()).thenAnswer((_) async => const Right(unit));

      final result = await refresh(const NoParams());

      expect(result, const Right<Failure, Unit>(unit));
      verifyInOrder([products.refreshProducts, home.refreshHomeContent, member.refreshMember]);
    });

    test('stops at the first failure and returns it', () async {
      when(() => products.refreshProducts()).thenAnswer((_) async => const Left(_offline));

      final result = await refresh(const NoParams());

      expect(result, const Left<Failure, Unit>(_offline));
      verifyNever(() => home.refreshHomeContent());
      verifyNever(() => member.refreshMember());
    });
  });

  group('SeedLocalDatabaseUseCase', () {
    late SeedLocalDatabaseUseCase seed;

    setUp(() => seed = SeedLocalDatabaseUseCase(products, home, member));

    test('seeds products before Home content, then the member record', () async {
      when(() => products.seedProductsIfEmpty()).thenAnswer((_) async => const Right(null));
      when(() => home.seedHomeContentIfEmpty()).thenAnswer((_) async => const Right(unit));
      when(() => member.seedMemberIfEmpty()).thenAnswer((_) async => const Right(unit));

      final result = await seed(const NoParams());

      expect(result.isRight(), isTrue);
      verifyInOrder([products.seedProductsIfEmpty, home.seedHomeContentIfEmpty, member.seedMemberIfEmpty]);
    });

    test('returns the failure when a seed file cannot be read', () async {
      const failure = CacheFailure('Seed data error', 'bad json');
      when(() => products.seedProductsIfEmpty()).thenAnswer((_) async => const Right(null));
      when(() => home.seedHomeContentIfEmpty()).thenAnswer((_) async => const Left(failure));

      final result = await seed(const NoParams());

      expect(result, const Left<Failure, Unit>(failure));
      verifyNever(() => member.seedMemberIfEmpty());
    });
  });
}
