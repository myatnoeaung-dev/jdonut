import 'package:drift/drift.dart';

import 'products_table.dart';

/// Which products appear in each Home section (seasonal, popular, order again), in order.
@DataClassName('HomeSectionItemRow')
class HomeSectionItems extends Table {
  TextColumn get sectionId => text()();
  TextColumn get productId => text().references(Products, #id)();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {sectionId, productId};
}
