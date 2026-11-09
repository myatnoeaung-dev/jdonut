import 'package:flutter_test/flutter_test.dart';

import 'package:drift/native.dart';

import 'package:jdonut/core/database/app_database.dart';
import 'package:jdonut/features/home/data/datasources/home_local_datasource.dart';
import 'package:jdonut/features/home/data/models/home_content_model.dart';
import 'package:jdonut/features/product/data/datasources/product_local_datasource.dart';
import 'package:jdonut/features/product/data/models/product_model.dart';

ProductModel _product(String id, String code) =>
    ProductModel(id: id, code: code, name: id, priceMmk: 1000, imageUrl: 'assets/$id.png', description: id);

final _coconut = _product('p_coconut', 'JD1');
final _sugar = _product('p_sugar', 'JD2');

const _banner = BannerModel(id: 'b1', tag: 'New', title: 'Hello', imageUrl: 'assets/b1.png');
const _shop = ShopModel(id: 's1', name: 'Shop', address: 'Yangon', imageUrl: 'assets/s1.png');

void main() {
  late AppDatabase database;
  late HomeLocalDatasource datasource;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    datasource = HomeLocalDatasourceImpl(database);
    await ProductLocalDatasourceImpl(database).upsertProducts([_coconut, _sugar]);
  });

  tearDown(() => database.close());

  test('reports no Home content on a fresh database', () async {
    expect(await datasource.hasHomeContent(), isFalse);
  });

  test('returns section products in the saved order, grouped by section', () async {
    await datasource.replaceHomeContent(
      const HomeContentModel(
        banners: [_banner],
        sections: [
          HomeSectionModel(id: 'popular', productIds: ['p_sugar', 'p_coconut']),
        ],
        shops: [_shop],
      ),
    );

    final snapshot = await datasource.watchHome().first;

    expect(await datasource.hasHomeContent(), isTrue);
    expect(snapshot.banners, [_banner]);
    expect(snapshot.shops, [_shop]);
    expect(snapshot.sectionProducts['popular'], [_sugar, _coconut]);
  });

  test('replacing the content removes what was there before', () async {
    await datasource.replaceHomeContent(const HomeContentModel(banners: [_banner], shops: [_shop]));
    await datasource.replaceHomeContent(
      const HomeContentModel(
        sections: [
          HomeSectionModel(id: 'seasonal', productIds: ['p_coconut']),
        ],
      ),
    );

    final snapshot = await datasource.watchHome().first;

    expect(snapshot.banners, isEmpty);
    expect(snapshot.shops, isEmpty);
    expect(snapshot.sectionProducts.keys, ['seasonal']);
  });

  test('emits again when a product shown on Home changes', () async {
    await datasource.replaceHomeContent(
      const HomeContentModel(
        sections: [
          HomeSectionModel(id: 'seasonal', productIds: ['p_coconut']),
        ],
      ),
    );
    final names = datasource.watchHome().map((snapshot) => snapshot.sectionProducts['seasonal']!.single.name);

    final expectation = expectLater(names, emitsInOrder(['p_coconut', 'Coconut Donut']));
    await Future<void>.delayed(Duration.zero);
    await ProductLocalDatasourceImpl(database).upsertProducts([_coconut.copyWith(name: 'Coconut Donut')]);

    await expectation;
  });
}
