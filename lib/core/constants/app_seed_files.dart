/// Seed JSON bundled under `assets/seed/`, loaded into the local database on
/// first run. The mock server answers `/v1` requests from the same files.
abstract final class AppSeedFiles {
  static const String products = 'assets/seed/products.json';
  static const String home = 'assets/seed/home.json';
  static const String member = 'assets/seed/member.json';
}
