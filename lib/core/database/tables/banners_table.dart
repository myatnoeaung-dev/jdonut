import 'package:drift/drift.dart';

/// Promo cards in the Home header carousel.
@DataClassName('BannerRow')
class Banners extends Table {
  TextColumn get id => text()();
  TextColumn get tag => text()();
  TextColumn get title => text()();
  TextColumn get imageUrl => text()();
  BoolColumn get showsShopIcon => boolean().withDefault(const Constant(false))();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
