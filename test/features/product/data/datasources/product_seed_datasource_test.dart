import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/constants/app_seed_files.dart';
import 'package:jdonut/core/database/seed/json_asset_loader.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/features/product/data/datasources/product_seed_datasource.dart';

class _StringAssetBundle extends CachingAssetBundle {
  _StringAssetBundle(this._contents);

  final String _contents;

  @override
  Future<ByteData> load(String key) async => ByteData.sublistView(Uint8List.fromList(_contents.codeUnits));

  @override
  Future<String> loadString(String key, {bool cache = true}) async => _contents;
}

void main() {
  test('parses every product in the bundled seed file', () async {
    final seedJson = File(AppSeedFiles.products).readAsStringSync();
    final datasource = ProductSeedDatasourceImpl(JsonAssetLoader(_StringAssetBundle(seedJson)));

    final products = await datasource.loadSeedProducts();

    expect(products, isNotEmpty);
    expect(products.first.id, 'p_coconut');
    expect(products.map((product) => product.id).toSet(), hasLength(products.length));
  });

  test('throws CacheFailure when the seed file is malformed', () async {
    final datasource = ProductSeedDatasourceImpl(JsonAssetLoader(_StringAssetBundle('{"not": "a list"}')));

    expect(datasource.loadSeedProducts, throwsA(isA<CacheFailure>()));
  });
}
