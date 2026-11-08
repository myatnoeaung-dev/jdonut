import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/database/app_database.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/features/product/data/datasources/product_local_datasource.dart';
import 'package:jdonut/features/product/data/models/product_model.dart';

const _coconut = ProductModel(
  id: 'p_coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: 3200,
  isNew: true,
  imageUrl: 'assets/images/products/p_coconut.png',
  description: 'Coconut',
);

const _sugar = ProductModel(
  id: 'p_classic_sugar',
  code: 'JD022127',
  name: 'Classic Sugar Donut',
  priceMmk: 2500,
  discountPercent: 20,
  imageUrl: 'assets/images/products/p_classic_sugar.png',
  description: 'Sugar',
);

void main() {
  late AppDatabase database;
  late ProductLocalDatasource datasource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    datasource = ProductLocalDatasourceImpl(database);
  });

  tearDown(() => database.close());

  test('reports no products on a fresh database', () async {
    expect(await datasource.hasProducts(), isFalse);
  });

  test('stores products and returns them ordered by code', () async {
    await datasource.upsertProducts([_sugar, _coconut]);

    expect(await datasource.hasProducts(), isTrue);
    expect(await datasource.watchProducts().first, [_coconut, _sugar]);
  });

  test('updates an existing product instead of duplicating it', () async {
    await datasource.upsertProducts([_coconut]);
    await datasource.upsertProducts([_coconut.copyWith(priceMmk: 3500)]);

    final products = await datasource.watchProducts().first;
    expect(products, hasLength(1));
    expect(products.single.priceMmk, 3500);
  });

  test('returns a product by id', () async {
    await datasource.upsertProducts([_coconut]);

    expect(await datasource.getProductById('p_coconut'), _coconut);
  });

  test('throws NotFoundFailure for an unknown id', () async {
    expect(() => datasource.getProductById('missing'), throwsA(isA<NotFoundFailure>()));
  });
}
