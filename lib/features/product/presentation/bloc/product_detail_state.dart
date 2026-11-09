part of 'product_detail_bloc.dart';

@freezed
abstract class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    @Default(PageStatus.initial) PageStatus status,

    /// Kept while reloading, so the page doesn't flash empty.
    Product? product,
    Failure? failure,
    @Default(ProductDetailState.minQuantity) int quantity,
  }) = _ProductDetailState;

  const ProductDetailState._();

  static const int minQuantity = 1;

  bool get isLoading => product == null && (status == PageStatus.initial || status == PageStatus.loading);

  /// No product has this id (an old link or a removed product).
  bool get isNotFound => product == null && failure is NotFoundFailure;

  bool get isBlockingError => product == null && status == PageStatus.error && !isNotFound;

  int get totalMmk => (product?.finalPriceMmk ?? 0) * quantity;
}
