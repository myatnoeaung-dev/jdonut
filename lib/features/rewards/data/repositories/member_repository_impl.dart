import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/repositories/base_repostitory.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_local_datasource.dart';
import '../datasources/member_remote_datasource.dart';
import '../datasources/member_seed_datasource.dart';

@LazySingleton(as: MemberRepository)
class MemberRepositoryImpl extends BaseRepository implements MemberRepository {
  const MemberRepositoryImpl(this._local, this._seed, this._remote, {required super.networkInfo});

  final MemberLocalDatasource _local;
  final MemberSeedDatasource _seed;
  final MemberRemoteDatasource _remote;

  @override
  Stream<Result<Member>> watchCurrentMember() => guardStream(_local.watchMember().map((model) => model.toEntity()));

  @override
  Future<Result<Unit>> seedMemberIfEmpty() => guard(() async {
    if (!await _local.hasMember()) await _local.saveMember(await _seed.loadSeedMember());
    return unit;
  });

  @override
  Future<Result<Unit>> refreshMember() =>
      refreshWhenOnline(fetchRemote: _remote.fetchCurrentMember, saveLocal: _local.saveMember);
}
