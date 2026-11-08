import 'package:drift/drift.dart';

/// Local user store for the fake phone-number auth. Added in schema v1 with
/// email/password columns; reshaped for phone sign-in in schema v2.
@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// International form, e.g. +959254135592.
  TextColumn get phoneNumber => text().unique()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  DateTimeColumn get birthDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
