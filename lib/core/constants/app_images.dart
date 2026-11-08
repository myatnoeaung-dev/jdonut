/// Paths of the raster images bundled under `assets/images/`.
abstract final class AppImages {
  static const String _products = 'assets/images/products';

  /// Bundled image for a seed product id (matches `imageUrl` in `assets/seed/products.json`).
  static String product(String productId) => '$_products/$productId.png';

  static final String donutStrawberry = product('p_strawberry_sprinkle');
  static final String donutChocolate = product('p_chocolate_glazed');
  static final String donutCoconut = product('p_coconut');
  static final String donutMatcha = product('p_matcha_cream');
  static final String donutSugar = product('p_classic_sugar');
  static final String donutCaramel = product('p_caramel_crunch');

  // Transparent donut artwork for the onboarding hero.
  static const String _donuts = 'assets/images/donuts';
  static const String donutMarshmallow = '$_donuts/marshmallow.png';
  static const String donutVanillaCaramel = '$_donuts/vanilla_caramel.png';
  static const String donutChocolateBiscoff = '$_donuts/chocolate_biscoff.png';
}
