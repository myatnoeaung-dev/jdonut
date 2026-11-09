import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/member.dart';
import '../repositories/member_repository.dart';

@lazySingleton
class WatchCurrentMemberUseCase implements StreamUseCase<Member, NoParams> {
  const WatchCurrentMemberUseCase(this._repository);

  final MemberRepository _repository;

  @override
  Stream<Result<Member>> call(NoParams params) => _repository.watchCurrentMember();
}
