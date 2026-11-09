import 'package:fpdart/fpdart.dart';

import '../../../../core/error/result.dart';
import '../entities/member.dart';

abstract interface class MemberRepository {
  /// The member's loyalty record from the local database; re-emits on change.
  /// A `NotFoundFailure` while there is no record yet.
  Stream<Result<Member>> watchCurrentMember();

  /// Loads the bundled member record on first run; does nothing if one exists.
  Future<Result<Unit>> seedMemberIfEmpty();

  /// Saves the server's member record locally. Being offline is not a failure.
  Future<Result<Unit>> refreshMember();
}
