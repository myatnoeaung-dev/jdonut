import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/core/constants/app_seed_files.dart';
import 'package:jdonut/features/home/data/models/home_content_model.dart';
import 'package:jdonut/features/home/domain/entities/home_content.dart';

void main() {
  test('parses the bundled Home seed file', () {
    final content = HomeContentModel.parse(jsonDecode(File(AppSeedFiles.home).readAsStringSync()));

    expect(content.banners, isNotEmpty);
    expect(content.shops, hasLength(4));
    // Every section id must match a HomeSectionType, or it would never show.
    final knownSections = HomeSectionType.values.map((type) => type.name);
    expect(content.sections.map((section) => section.id), everyElement(isIn(knownSections)));
  });

  test('every product a seed section points at exists in the product seed file', () {
    final content = HomeContentModel.parse(jsonDecode(File(AppSeedFiles.home).readAsStringSync()));
    final products = jsonDecode(File(AppSeedFiles.products).readAsStringSync()) as List<dynamic>;
    final productIds = products.map((product) => (product as Map<String, dynamic>)['id']).toSet();

    final sectionProductIds = content.sections.expand((section) => section.productIds);

    expect(sectionProductIds, everyElement(isIn(productIds)));
  });

  test('section rows keep the product order as positions', () {
    const section = HomeSectionModel(id: 'popular', productIds: ['p_a', 'p_b']);

    final rows = section.toCompanions();

    expect(rows.map((row) => (row.productId.value, row.position.value)), [('p_a', 0), ('p_b', 1)]);
  });

  test('banner defaults: no shop icon, first position', () {
    final banner = BannerModel.fromJson(const {'id': 'b', 'tag': 'T', 'title': 'Title', 'imageUrl': 'assets/b.png'});

    expect(banner.showsShopIcon, isFalse);
    expect(banner.position, 0);
    expect(banner.toEntity().title, 'Title');
  });
}
