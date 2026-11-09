import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_guard.dart';
import '../../../product/data/models/product_model.dart';
import '../models/home_content_model.dart';

/// What Home shows, as stored: section products are grouped by section id.
typedef HomeSnapshot = ({
  List<BannerModel> banners,
  Map<String, List<ProductModel>> sectionProducts,
  List<ShopModel> shops,
});

abstract interface class HomeLocalDatasource {
  /// Emits now and again whenever banners, sections, shops or products change.
  Stream<HomeSnapshot> watchHome();

  Future<bool> hasHomeContent();

  /// Swaps all Home content for [content] in one transaction.
  Future<void> replaceHomeContent(HomeContentModel content);
}

@LazySingleton(as: HomeLocalDatasource)
class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  const HomeLocalDatasourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<HomeSnapshot> watchHome() {
    final db = _database;
    final changes = db.customSelect('SELECT 1', readsFrom: {db.banners, db.homeSectionItems, db.shops, db.products});
    return changes.watch().asyncMap((_) => _readSnapshot());
  }

  @override
  Future<bool> hasHomeContent() => guardLocal(() async {
    final db = _database;
    final banner = await (db.select(db.banners)..limit(1)).getSingleOrNull();
    final item = await (db.select(db.homeSectionItems)..limit(1)).getSingleOrNull();
    return banner != null || item != null;
  });

  @override
  Future<void> replaceHomeContent(HomeContentModel content) => guardLocal(
    () => _database.transaction(() async {
      final db = _database;
      await db.delete(db.homeSectionItems).go();
      await db.delete(db.banners).go();
      await db.delete(db.shops).go();
      await db.batch((batch) {
        batch
          ..insertAll(db.banners, content.banners.map((banner) => banner.toCompanion()))
          ..insertAll(db.homeSectionItems, content.sections.expand((section) => section.toCompanions()))
          ..insertAll(db.shops, content.shops.map((shop) => shop.toCompanion()));
      });
    }),
  );

  Future<HomeSnapshot> _readSnapshot() async {
    final db = _database;
    final banners = await (db.select(db.banners)..orderBy([(table) => OrderingTerm.asc(table.position)])).get();
    final shops = await (db.select(db.shops)..orderBy([(table) => OrderingTerm.asc(table.position)])).get();
    return (
      banners: banners.map(BannerModel.fromRow).toList(),
      sectionProducts: await _readSectionProducts(),
      shops: shops.map(ShopModel.fromRow).toList(),
    );
  }

  Future<Map<String, List<ProductModel>>> _readSectionProducts() async {
    final db = _database;
    final query = db.select(db.homeSectionItems).join([
      innerJoin(db.products, db.products.id.equalsExp(db.homeSectionItems.productId)),
    ])..orderBy([OrderingTerm.asc(db.homeSectionItems.position)]);
    final sections = <String, List<ProductModel>>{};
    for (final row in await query.get()) {
      final sectionId = row.readTable(db.homeSectionItems).sectionId;
      sections.putIfAbsent(sectionId, () => []).add(ProductModel.fromRow(row.readTable(db.products)));
    }
    return sections;
  }
}
