import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/local_guard.dart';
import '../../../../core/error/failure.dart';
import '../models/member_model.dart';

abstract interface class MemberLocalDatasource {
  /// The single member record; the stream errors with [NotFoundFailure] while there is none.
  Stream<MemberModel> watchMember();

  Future<bool> hasMember();

  /// Replaces the stored record, so there is always exactly one.
  Future<void> saveMember(MemberModel member);
}

@LazySingleton(as: MemberLocalDatasource)
class MemberLocalDatasourceImpl implements MemberLocalDatasource {
  const MemberLocalDatasourceImpl(this._database);

  final AppDatabase _database;

  @override
  Stream<MemberModel> watchMember() {
    final query = _database.select(_database.members)..limit(1);
    return query.watchSingleOrNull().map((row) {
      if (row == null) throw const NotFoundFailure('Member not found', 'No member record saved yet');
      return MemberModel.fromRow(row);
    });
  }

  @override
  Future<bool> hasMember() => guardLocal(() async {
    final row = await (_database.select(_database.members)..limit(1)).getSingleOrNull();
    return row != null;
  });

  @override
  Future<void> saveMember(MemberModel member) => guardLocal(
    () => _database.transaction(() async {
      await _database.delete(_database.members).go();
      await _database.into(_database.members).insert(member.toCompanion());
    }),
  );
}
