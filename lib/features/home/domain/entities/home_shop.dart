import 'package:equatable/equatable.dart';

/// A J'Donut shop in the "near you" row at the bottom of Home.
class HomeShop extends Equatable {
  const HomeShop({required this.id, required this.name, required this.address, required this.imageUrl});

  final String id;
  final String name;
  final String address;

  /// Bundled asset path or network URL.
  final String imageUrl;

  @override
  List<Object?> get props => [id, name, address, imageUrl];
}
