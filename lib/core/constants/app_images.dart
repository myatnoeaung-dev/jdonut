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

  /// Shop photo for the "New shop" banner on Home (placeholder until added).
  static const String bannerNewShop = 'assets/images/banner_new_shop.png';

  /// Sky-and-grass background behind the nearby shops section on Home.
  static const String nearbyShopsBackground = 'assets/images/nearby_shops_bg.png';

  /// Sample member photo on Home (falls back to the initial until added).
  static const String avatarSample = 'assets/images/avatar_sample.png';

  // Drinks on Rewards challenges (placeholder until the artwork is added).
  static const String americano = 'assets/images/drinks/americano.png';
  static const String latte = 'assets/images/drinks/latte.png';

  // Transparent donut artwork for the onboarding hero.
  static const String _donuts = 'assets/images/donuts';
  static const String donutMarshmallow = '$_donuts/marshmallow.png';
  static const String donutVanillaCaramel = '$_donuts/vanilla_caramel.png';
  static const String donutChocolateBiscoff = '$_donuts/chocolate_biscoff.png';
  static const String donutHoneyLemon = '$_donuts/honey_lemon.png';
  static const String donutCreamyMilkFilling = '$_donuts/creamy_milk_filling.png';
  static const String donutTiramisuPanna = '$_donuts/tiramisu_panna.png';
}
