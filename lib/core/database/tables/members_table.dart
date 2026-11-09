import 'package:drift/drift.dart';

/// The member's loyalty record. Home, Rewards and Settings all read this one row.
@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();

  /// `bronze`, `silver` or `gold`.
  TextColumn get tier => text()();
  IntColumn get loyaltyPoints => integer()();

  /// Points needed to reach the next tier; ignored at the top tier.
  IntColumn get nextTierPoints => integer()();
  IntColumn get unreadNotifications => integer().withDefault(const Constant(0))();
  TextColumn get avatarUrl => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
