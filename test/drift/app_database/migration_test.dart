// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:jdonut/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldUsersData = <v1.UsersData>[];
    final expectedNewUsersData = <v2.UsersData>[];

    final oldProductsData = <v1.ProductsData>[];
    final expectedNewProductsData = <v2.ProductsData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.users, oldUsersData);
        batch.insertAll(oldDb.products, oldProductsData);
      },
      validateItems: (newDb) async {
        expect(expectedNewUsersData, await newDb.select(newDb.users).get());
        expect(
          expectedNewProductsData,
          await newDb.select(newDb.products).get(),
        );
      },
    );
  });

  test('migration from v2 to v3 keeps users and products and adds empty Home tables', () async {
    const user = v2.UsersData(
      id: 1,
      phoneNumber: '+959254135592',
      firstName: 'Hania',
      birthDate: '1995-05-01T00:00:00.000',
      createdAt: '2026-01-01T00:00:00.000',
    );
    const product = v2.ProductsData(
      id: 'p_coconut',
      code: 'JD022123',
      name: 'Coconut Donut',
      priceMmk: 3200,
      isNew: 1,
      imageUrl: 'assets/images/donuts/vanilla_caramel.png',
      description: 'Coconut',
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.users, [user]);
        batch.insertAll(oldDb.products, [product]);
      },
      validateItems: (newDb) async {
        expect(
          (await newDb.select(newDb.users).get()).single.phoneNumber,
          user.phoneNumber,
        );
        expect(
          (await newDb.select(newDb.products).get()).single.name,
          product.name,
        );
        expect(await newDb.select(newDb.banners).get(), isEmpty);
        expect(await newDb.select(newDb.members).get(), isEmpty);
      },
    );
  });
}
