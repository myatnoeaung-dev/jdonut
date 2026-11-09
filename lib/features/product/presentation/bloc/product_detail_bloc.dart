import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/page_status.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/watch_product_by_id_use_case.dart';

part 'product_detail_bloc.freezed.dart';
part 'product_detail_event.dart';
part 'product_detail_state.dart';

/// `/product/:id`: the product from the local database (so it works offline
/// and follows background refreshes) and the chosen quantity.
@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc(this._watchProductById) : super(const ProductDetailState()) {
    on<ProductDetailStarted>(_onStarted, transformer: restartable());
    on<ProductQuantityChanged>(_onQuantityChanged);
  }

  final WatchProductByIdUseCase _watchProductById;

  Future<void> _onStarted(ProductDetailStarted event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(status: PageStatus.loading, failure: null));
    await emit.forEach(
      _watchProductById(event.productId),
      onData: (result) => result.match(
        (failure) => state.copyWith(status: PageStatus.error, failure: failure),
        (product) => state.copyWith(status: PageStatus.success, product: product, failure: null),
      ),
    );
  }

  void _onQuantityChanged(ProductQuantityChanged event, Emitter<ProductDetailState> emit) {
    if (event.quantity < ProductDetailState.minQuantity) return;
    emit(state.copyWith(quantity: event.quantity));
  }
}
