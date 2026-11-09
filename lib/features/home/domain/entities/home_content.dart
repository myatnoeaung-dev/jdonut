import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product.dart';
import 'home_banner.dart';
import 'home_shop.dart';

/// Product rows on Home, in display order. The names match the section ids in
/// the seed JSON and the API.
enum HomeSectionType { seasonal, popular, orderAgain }

class HomeSection extends Equatable {
  const HomeSection({required this.type, required this.products});

  final HomeSectionType type;
  final List<Product> products;

  @override
  List<Object?> get props => [type, products];
}

/// Everything Home shows below the member header, read from the local database.
class HomeContent extends Equatable {
  const HomeContent({required this.banners, required this.sections, required this.shops});

  final List<HomeBanner> banners;

  /// Only sections that have products, in [HomeSectionType] order.
  final List<HomeSection> sections;
  final List<HomeShop> shops;

  bool get isEmpty => banners.isEmpty && sections.isEmpty && shops.isEmpty;

  @override
  List<Object?> get props => [banners, sections, shops];
}
