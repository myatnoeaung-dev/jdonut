import 'package:equatable/equatable.dart';

/// Promo card in the Home header carousel.
class HomeBanner extends Equatable {
  const HomeBanner({
    required this.id,
    required this.tag,
    required this.title,
    required this.imageUrl,
    this.showsShopIcon = false,
  });

  final String id;
  final String tag;
  final String title;

  /// Bundled asset path or network URL.
  final String imageUrl;

  /// Shop badge on top of the photo (new-shop banners).
  final bool showsShopIcon;

  @override
  List<Object?> get props => [id, tag, title, imageUrl, showsShopIcon];
}
