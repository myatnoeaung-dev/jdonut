import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

import 'app_database.steps.dart';
import 'tables/banners_table.dart';
import 'tables/home_section_items_table.dart';
import 'tables/members_table.dart';
import 'tables/products_table.dart';
import 'tables/shops_table.dart';
import 'tables/users_table.dart';

export 'tables/banners_table.dart';
export 'tables/home_section_items_table.dart';
export 'tables/members_table.dart';
export 'tables/products_table.dart';
export 'tables/shops_table.dart';
export 'tables/users_table.dart';

part 'app_database.g.dart';

/// The single local database the UI reads from.
///
/// Schema changes: add/alter tables, bump [schemaVersion], run
/// `dart run drift_dev make-migrations`, then fill in the new step in [migration].
@DriftDatabase(tables: [Users, Products, Banners, HomeSectionItems, Shops, Members])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  static const String fileName = 'jdonut';

  @override
  int get schemaVersion => 3;

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
      // v3: Home content and the member's loyalty record move into the database.
      from2To3: (migrator, schema) async {
        await migrator.createTable(schema.banners);
        await migrator.createTable(schema.homeSectionItems);
        await migrator.createTable(schema.shops);
        await migrator.createTable(schema.members);
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
