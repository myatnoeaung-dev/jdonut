import '../../../../core/constants/app_images.dart';
import '../../domain/entities/product.dart';

/// UI-only sample catalogue matching the design. Replaced by products from the
/// local database once the blocs are wired up.
abstract final class SampleProducts {
  static const String _donutDescription =
      'Enjoy our scrumptious donuts – soft, sweet, and satisfying in every bite. '
      'Choose from classic glazed, rich chocolate, or fun sprinkles. Dive into deliciousness now!';

  static final Product coconut = Product(
    id: 'p_coconut',
    code: 'JD022123',
    name: 'Coconut Donut',
    priceMmk: 3200,
    isNew: true,
    discountPercent: null,
    imageUrl: AppImages.donutVanillaCaramel,
    description: _donutDescription,
  );

  static final Product strawberryChocolate = Product(
    id: 'p_strawberry_chocolate',
    code: 'JD022124',
    name: 'Strawberry Chocolate Donuts',
    priceMmk: 3500,
    isNew: false,
    discountPercent: null,
    imageUrl: AppImages.donutChocolateBiscoff,
    description: _donutDescription,
  );

  static final Product dalgonaCoffee = Product(
    id: 'p_dalgona_coffee',
    code: 'JD022125',
    name: 'Dalgona Creamy Coffee',
    priceMmk: 4500,
    isNew: false,
    discountPercent: null,
    imageUrl: AppImages.product('p_dalgona_coffee'),
    description: 'Whipped coffee cream over chilled milk.',
  );

  static final Product mistletoeBox = Product(
    id: 'p_mistletoe_box',
    code: 'JD022126',
    name: 'Mistletoe Romance box',
    priceMmk: 18000,
    isNew: false,
    discountPercent: 30,
    imageUrl: AppImages.donutMarshmallow,
    description: 'A festive box of six assorted donuts.',
  );

  static final Product christmasBox = Product(
    id: 'p_christmas_box',
    code: 'JD022127',
    name: 'Christmas Mini Family box',
    priceMmk: 24000,
    isNew: false,
    discountPercent: null,
    imageUrl: AppImages.product('p_christmas_box'),
    description: 'Twelve mini donuts to share.',
  );

  static final Product santaCookies = Product(
    id: 'p_santa_cookies',
    code: 'JD022128',
    name: "Santa's favorite cookies set",
    priceMmk: 9000,
    isNew: false,
    discountPercent: 30,
    imageUrl: AppImages.donutChocolateBiscoff,
    description: 'Chocolate biscoff donuts with cookie crumble.',
  );

  static final List<Product> all = [
    coconut,
    strawberryChocolate,
    dalgonaCoffee,
    mistletoeBox,
    christmasBox,
    santaCookies,
  ];

  static Product? byId(String id) {
    for (final product in all) {
      if (product.id == id) return product;
    }
    return null;
  }
}
