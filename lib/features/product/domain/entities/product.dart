import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.discountPercent,
    required this.imageUrl,
    required this.description,
  });

  static const int _fullPercent = 100;

  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;

  /// Bundled asset path for seed data, or a network URL from the server.
  final String imageUrl;
  final String description;

  bool get hasDiscount => (discountPercent ?? 0) > 0;

  /// Price after discount, rounded to the nearest kyat.
  int get finalPriceMmk {
    final percent = discountPercent;
    if (percent == null || percent <= 0) return priceMmk;
    return (priceMmk * (_fullPercent - percent) / _fullPercent).round();
  }

  @override
  List<Object?> get props => [id, code, name, priceMmk, isNew, discountPercent, imageUrl, description];
}
