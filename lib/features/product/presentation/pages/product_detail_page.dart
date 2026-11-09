import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/coming_soon_snack_bar.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/state_views.dart';
import '../bloc/product_detail_bloc.dart';
import '../widgets/product_details_view.dart';

/// `/product/:id`. Reads the product from the local database, so it opens offline too.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductDetailBloc>()..add(ProductDetailStarted(productId)),
      child: Scaffold(
        backgroundColor: context.palette.pageBackground,
        body: OfflineBannerOverlay(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(onPressed: () => context.canPop() ? context.pop() : null),
                ),
                Expanded(child: _ProductDetailBody(productId: productId)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDetailBody extends StatelessWidget {
  const _ProductDetailBody({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        final bloc = context.read<ProductDetailBloc>();
        final product = state.product;
        if (state.isLoading) return const LoadingView();
        if (state.isNotFound) return EmptyView(message: context.l10n.productNotFound);
        if (product == null) return ErrorView(onRetry: () => bloc.add(ProductDetailStarted(productId)));
        return ProductDetailsView(
          product: product,
          quantity: state.quantity,
          totalMmk: state.totalMmk,
          onQuantityChanged: (quantity) => bloc.add(ProductQuantityChanged(quantity)),
          onAddToCart: () => showComingSoon(context),
        );
      },
    );
  }
}
