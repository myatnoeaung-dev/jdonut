part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Start (or retry) following the product with [productId].
final class ProductDetailStarted extends ProductDetailEvent {
  const ProductDetailStarted(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

final class ProductQuantityChanged extends ProductDetailEvent {
  const ProductQuantityChanged(this.quantity);

  final int quantity;

  @override
  List<Object?> get props => [quantity];
}
