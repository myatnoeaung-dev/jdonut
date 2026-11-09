import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../product/domain/repositories/product_repository.dart';
import '../../../rewards/domain/repositories/member_repository.dart';
import '../repositories/home_repository.dart';

/// Refreshes everything Home shows: products first (Home sections point at
/// them), then the Home content, then the member record. Stops at the first
/// failure; whatever is already saved stays on screen.
@lazySingleton
class RefreshHomeContentUseCase implements UseCase<Unit, NoParams> {
  const RefreshHomeContentUseCase(this._products, this._home, this._member);

  final ProductRepository _products;
  final HomeRepository _home;
  final MemberRepository _member;

  @override
  Future<Result<Unit>> call(NoParams params) async {
    final steps = [_products.refreshProducts, _home.refreshHomeContent, _member.refreshMember];
    for (final refresh in steps) {
      final result = await refresh();
      if (result.isLeft()) return result;
    }
    return const Right(unit);
  }
}
