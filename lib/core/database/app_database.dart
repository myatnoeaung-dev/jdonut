import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

import 'app_database.steps.dart';
import 'tables/products_table.dart';
import 'tables/users_table.dart';

export 'tables/products_table.dart';
export 'tables/users_table.dart';

part 'app_database.g.dart';

/// The single local database the UI reads from.
///
/// Schema changes: add/alter tables, bump [schemaVersion], run
/// `dart run drift_dev make-migrations`, then fill in the new step in [migration].
@DriftDatabase(tables: [Users, Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  static const String fileName = 'jdonut';

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: stepByStep(
      // v2: users switch from email/password to phone sign-in. v1 rows have no
      // phone number to carry over, so the table is recreated empty.
      from1To2: (migrator, schema) async {
        await migrator.deleteTable(schema.users.actualTableName);
        await migrator.createTable(schema.users);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

@module
abstract class DatabaseModule {
  @LazySingleton(dispose: closeDatabase)
  AppDatabase get database => AppDatabase(driftDatabase(name: AppDatabase.fileName));
}

Future<void> closeDatabase(AppDatabase database) => database.close();
