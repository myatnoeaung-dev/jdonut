import 'package:flutter_test/flutter_test.dart';

import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/usecase/usecase.dart';
import 'package:jdonut/features/product/domain/entities/product.dart';
import 'package:jdonut/features/product/domain/repositories/product_repository.dart';
import 'package:jdonut/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:jdonut/features/product/domain/usecases/watch_product_by_id_use_case.dart';
import 'package:jdonut/features/product/domain/usecases/watch_products_use_case.dart';

class _MockProductRepository extends Mock implements ProductRepository {}

const _coconut = Product(
  id: 'p_coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  discountPercent: null,
  imageUrl: 'assets/images/products/p_coconut.png',
  description: 'Coconut',
);

void main() {
  late _MockProductRepository repository;

  setUp(() => repository = _MockProductRepository());

  test('WatchProductsUseCase emits the products from the repository', () {
    when(() => repository.watchProducts()).thenAnswer((_) => Stream.value(const Right([_coconut])));

    expect(WatchProductsUseCase(repository)(const NoParams()), emits(const Right<Failure, List<Product>>([_coconut])));
  });

  test('GetProductByIdUseCase returns the product for a known id', () async {
    when(() => repository.getProductById('p_coconut')).thenAnswer((_) async => const Right(_coconut));

    expect(await GetProductByIdUseCase(repository)('p_coconut'), const Right<Failure, Product>(_coconut));
  });

  test('GetProductByIdUseCase returns NotFoundFailure for an unknown id', () async {
    const failure = NotFoundFailure('Product not found', null);
    when(() => repository.getProductById('missing')).thenAnswer((_) async => const Left(failure));

    expect(await GetProductByIdUseCase(repository)('missing'), const Left<Failure, Product>(failure));
  });

  test('WatchProductByIdUseCase emits the product for the given id', () {
    when(() => repository.watchProductById('p_coconut')).thenAnswer((_) => Stream.value(const Right(_coconut)));

    expect(WatchProductByIdUseCase(repository)('p_coconut'), emits(const Right<Failure, Product>(_coconut)));
  });
}
