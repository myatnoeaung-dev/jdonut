import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/product/domain/entities/product.dart';

Product _product({int priceMmk = 3200, int? discountPercent}) => Product(
  id: 'p_coconut',
  code: 'JD022123',
  name: 'Coconut Donut',
  priceMmk: priceMmk,
  isNew: true,
  discountPercent: discountPercent,
  imageUrl: 'assets/images/products/p_coconut.png',
  description: 'Enjoy our scrumptious donuts',
);

void main() {
  group('Product.finalPriceMmk', () {
    test('equals the list price when there is no discount', () {
      expect(_product().finalPriceMmk, 3200);
      expect(_product().hasDiscount, isFalse);
    });

    test('applies the discount percentage', () {
      final product = _product(priceMmk: 3000, discountPercent: 10);

      expect(product.finalPriceMmk, 2700);
      expect(product.hasDiscount, isTrue);
    });

    test('rounds to the nearest kyat', () {
      expect(_product(priceMmk: 3333, discountPercent: 15).finalPriceMmk, 2833);
    });

    test('treats a zero discount as no discount', () {
      expect(_product(discountPercent: 0).hasDiscount, isFalse);
    });
  });
}
