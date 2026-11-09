import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/page_status.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/features/product/domain/entities/product.dart';
import 'package:jdonut/features/product/domain/usecases/watch_product_by_id_use_case.dart';
import 'package:jdonut/features/product/presentation/bloc/product_detail_bloc.dart';

class _MockWatchProduct extends Mock implements WatchProductByIdUseCase {}

const _coconut = Product(
  id: 'p_coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  discountPercent: null,
  imageUrl: 'assets/c.png',
  description: 'Coconut',
);

void main() {
  late _MockWatchProduct watchProduct;

  setUp(() => watchProduct = _MockWatchProduct());

  blocTest<ProductDetailBloc, ProductDetailState>(
    'emits [loading, success] with the product from the local database',
    setUp: () => when(() => watchProduct('p_coconut')).thenAnswer((_) => Stream.value(const Right(_coconut))),
    build: () => ProductDetailBloc(watchProduct),
    act: (bloc) => bloc.add(const ProductDetailStarted('p_coconut')),
    expect: () => [
      const ProductDetailState(status: PageStatus.loading),
      const ProductDetailState(status: PageStatus.success, product: _coconut),
    ],
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'shows not found for an unknown product id',
    setUp: () =>
        when(() => watchProduct('missing'))
            .thenAnswer((_) => Stream.value(const Left(NotFoundFailure('Product not found', null)))),
    build: () => ProductDetailBloc(watchProduct),
    act: (bloc) => bloc.add(const ProductDetailStarted('missing')),
    skip: 1,
    expect: () => [isA<ProductDetailState>().having((state) => state.isNotFound, 'isNotFound', isTrue)],
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'shows a retryable error when the database cannot be read',
    setUp: () =>
        when(() => watchProduct('p_coconut'))
            .thenAnswer((_) => Stream.value(const Left(CacheFailure('Local database error', null)))),
    build: () => ProductDetailBloc(watchProduct),
    act: (bloc) => bloc.add(const ProductDetailStarted('p_coconut')),
    skip: 1,
    expect: () => [
      isA<ProductDetailState>()
          .having((state) => state.isBlockingError, 'isBlockingError', isTrue)
          .having((state) => state.isNotFound, 'isNotFound', isFalse),
    ],
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'updates the quantity and the total price',
    build: () => ProductDetailBloc(watchProduct),
    seed: () => const ProductDetailState(status: PageStatus.success, product: _coconut),
    act: (bloc) => bloc.add(const ProductQuantityChanged(3)),
    expect: () => [
      isA<ProductDetailState>()
          .having((state) => state.quantity, 'quantity', 3)
          .having((state) => state.totalMmk, 'totalMmk', 9600),
    ],
  );

  blocTest<ProductDetailBloc, ProductDetailState>(
    'ignores a quantity below one',
    build: () => ProductDetailBloc(watchProduct),
    seed: () => const ProductDetailState(product: _coconut),
    act: (bloc) => bloc.add(const ProductQuantityChanged(0)),
    expect: () => <ProductDetailState>[],
  );
}
