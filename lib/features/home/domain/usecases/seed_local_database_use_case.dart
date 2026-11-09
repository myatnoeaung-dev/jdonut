import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../product/domain/repositories/product_repository.dart';
import '../../../rewards/domain/repositories/member_repository.dart';
import '../repositories/home_repository.dart';

/// First launch: fills the local database from the bundled JSON, so the app
/// works fully offline from then on. Products go first because Home sections
/// point at them. Each part is skipped when it already has data.
@lazySingleton
class SeedLocalDatabaseUseCase implements UseCase<Unit, NoParams> {
  const SeedLocalDatabaseUseCase(this._products, this._home, this._member);

  final ProductRepository _products;
  final HomeRepository _home;
  final MemberRepository _member;

  @override
  Future<Result<Unit>> call(NoParams params) async {
    final steps = <Future<Either<Failure, Object?>> Function()>[
      _products.seedProductsIfEmpty,
      _home.seedHomeContentIfEmpty,
      _member.seedMemberIfEmpty,
    ];
    for (final seed in steps) {
      final result = await seed();
      if (result case Left(:final value)) return Left(value);
    }
    return const Right(unit);
  }
}
