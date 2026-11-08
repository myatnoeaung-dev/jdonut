import 'package:drift/drift.dart';

/// Local user store for fake auth. Passwords are stored as salted hashes only.
@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullName => text()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get passwordSalt => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
