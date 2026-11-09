import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/page_status.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/usecase/usecase.dart';
import 'package:jdonut/features/rewards/domain/entities/member.dart';
import 'package:jdonut/features/rewards/domain/usecases/watch_current_member_use_case.dart';
import 'package:jdonut/features/rewards/presentation/bloc/member/member_bloc.dart';

class _MockWatchMember extends Mock implements WatchCurrentMemberUseCase {}

const _silver = Member(
  id: 'm_current',
  tier: MemberTier.silver,
  loyaltyPoints: 500,
  nextTierPoints: 1000,
  unreadNotifications: 2,
);

void main() {
  late _MockWatchMember watchMember;

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() => watchMember = _MockWatchMember());

  blocTest<MemberBloc, MemberState>(
    'emits [loading, success] with the saved member',
    setUp: () => when(() => watchMember(any())).thenAnswer((_) => Stream.value(const Right(_silver))),
    build: () => MemberBloc(watchMember),
    act: (bloc) => bloc.add(const MemberStarted()),
    expect: () => [
      const MemberState(status: PageStatus.loading),
      const MemberState(status: PageStatus.success, member: _silver),
    ],
  );

  blocTest<MemberBloc, MemberState>(
    'emits [loading, error] when no member record is saved',
    setUp: () =>
        when(() => watchMember(any()))
            .thenAnswer((_) => Stream.value(const Left(NotFoundFailure('Member not found', null)))),
    build: () => MemberBloc(watchMember),
    act: (bloc) => bloc.add(const MemberStarted()),
    expect: () => [
      const MemberState(status: PageStatus.loading),
      const MemberState(status: PageStatus.error, failure: NotFoundFailure('Member not found', null)),
    ],
  );
}
