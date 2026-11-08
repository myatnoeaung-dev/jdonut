import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/product/data/models/product_model.dart';

void main() {
  const json = {
    'id': 'p_coconut',
    'code': 'JD022123',
    'name': 'Coconut Donut',
    'priceMmk': 3200,
    'isNew': true,
    'discountPercent': null,
    'imageUrl': 'https://example.com/coconut.png',
    'description': 'Enjoy our scrumptious donuts',
  };

  test('parses the API/seed JSON shape and maps it to a Product entity', () {
    final product = ProductModel.fromJson(json).toEntity();

    expect(product.id, 'p_coconut');
    expect(product.code, 'JD022123');
    expect(product.priceMmk, 3200);
    expect(product.isNew, isTrue);
    expect(product.discountPercent, isNull);
  });

  test('defaults isNew to false when the field is missing', () {
    final withoutIsNew = Map<String, dynamic>.of(json)..remove('isNew');

    expect(ProductModel.fromJson(withoutIsNew).isNew, isFalse);
  });

  test('round-trips through toJson', () {
    expect(ProductModel.fromJson(json).toJson(), json);
  });
}
