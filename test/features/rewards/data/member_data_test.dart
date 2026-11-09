import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/constants/app_seed_files.dart';
import 'package:jdonut/core/database/app_database.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/network/network_info.dart';
import 'package:jdonut/features/rewards/data/datasources/member_local_datasource.dart';
import 'package:jdonut/features/rewards/data/datasources/member_remote_datasource.dart';
import 'package:jdonut/features/rewards/data/datasources/member_seed_datasource.dart';
import 'package:jdonut/features/rewards/data/models/member_model.dart';
import 'package:jdonut/features/rewards/data/repositories/member_repository_impl.dart';
import 'package:jdonut/features/rewards/domain/entities/member.dart';

class _MockSeed extends Mock implements MemberSeedDatasource {}

class _MockRemote extends Mock implements MemberRemoteDatasource {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

const _silver = MemberModel(id: 'm_current', tier: 'silver', loyaltyPoints: 500, nextTierPoints: 1000);

void main() {
  group('MemberModel', () {
    test('parses the bundled member seed file as Silver with 500 points to Gold', () {
      final member = MemberModel.parse(jsonDecode(File(AppSeedFiles.member).readAsStringSync())).toEntity();

      expect(member.tier, MemberTier.silver);
      expect(member.nextTier, MemberTier.gold);
      expect(member.pointsToNextTier, 500);
    });

    test('an unknown tier name falls back to bronze', () {
      expect(_silver.copyWith(tier: 'diamond').toEntity().tier, MemberTier.bronze);
    });
  });

  group('MemberLocalDatasource', () {
    late AppDatabase database;
    late MemberLocalDatasource local;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      local = MemberLocalDatasourceImpl(database);
    });

    tearDown(() => database.close());

    test('errors with NotFoundFailure while no member is saved', () {
      expect(local.watchMember(), emitsError(isA<NotFoundFailure>()));
    });

    test('keeps exactly one member record when saved twice', () async {
      await local.saveMember(_silver);
      await local.saveMember(_silver.copyWith(id: 'm_other', loyaltyPoints: 900));

      expect(await database.select(database.members).get(), hasLength(1));
      expect((await local.watchMember().first).loyaltyPoints, 900);
    });
  });

  group('MemberRepositoryImpl', () {
    late AppDatabase database;
    late _MockSeed seed;
    late _MockRemote remote;
    late _MockNetworkInfo networkInfo;
    late MemberRepositoryImpl repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      seed = _MockSeed();
      remote = _MockRemote();
      networkInfo = _MockNetworkInfo();
      repository = MemberRepositoryImpl(MemberLocalDatasourceImpl(database), seed, remote, networkInfo: networkInfo);
      when(() => seed.loadSeedMember()).thenAnswer((_) async => _silver);
    });

    tearDown(() => database.close());

    test('seeds the member once and emits it', () async {
      await repository.seedMemberIfEmpty();
      await repository.seedMemberIfEmpty();

      verify(() => seed.loadSeedMember()).called(1);
      final member = (await repository.watchCurrentMember().first).getRight().toNullable();
      expect(member?.tier, MemberTier.silver);
    });

    test('a failed refresh returns the failure and keeps the saved member', () async {
      const failure = ServerFailure('500', 'down');
      await repository.seedMemberIfEmpty();
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchCurrentMember()).thenThrow(failure);

      final result = await repository.refreshMember();

      expect(result.getLeft().toNullable(), failure);
      expect((await repository.watchCurrentMember().first).isRight(), isTrue);
    });
  });
}
