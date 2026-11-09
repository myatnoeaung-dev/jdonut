import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/page_status.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/error/result.dart';
import 'package:jdonut/core/usecase/usecase.dart';
import 'package:jdonut/features/home/domain/entities/home_content.dart';
import 'package:jdonut/features/home/domain/entities/home_shop.dart';
import 'package:jdonut/features/home/domain/usecases/refresh_home_content_use_case.dart';
import 'package:jdonut/features/home/domain/usecases/watch_home_content_use_case.dart';
import 'package:jdonut/features/home/presentation/bloc/home_bloc.dart';

class _MockWatch extends Mock implements WatchHomeContentUseCase {}

class _MockRefresh extends Mock implements RefreshHomeContentUseCase {}

const _content = HomeContent(
  banners: [],
  sections: [],
  shops: [HomeShop(id: 's1', name: 'Shop', address: 'Yangon', imageUrl: 'assets/s.png')],
);
const _empty = HomeContent(banners: [], sections: [], shops: []);
const _diskError = CacheFailure('Local database error', 'disk full');
const _offline = ConnectionFailure('Check network connections', 'timeout');

void main() {
  late _MockWatch watch;
  late _MockRefresh refresh;
  late StreamController<Result<HomeContent>> saved;

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    watch = _MockWatch();
    refresh = _MockRefresh();
    saved = StreamController<Result<HomeContent>>();
    when(() => watch(any())).thenAnswer((_) => saved.stream);
    when(() => refresh(any())).thenAnswer((_) async => const Right(unit));
  });

  // Not awaited: close() never completes for a stream nobody listened to.
  tearDown(() => unawaited(saved.close()));

  HomeBloc build() => HomeBloc(watch, refresh);

  blocTest<HomeBloc, HomeState>(
    'emits [loading, success] with the saved content and refreshes once in the background',
    build: build,
    act: (bloc) async {
      bloc.add(const HomeStarted());
      await Future<void>.delayed(Duration.zero);
      saved.add(const Right(_content));
    },
    expect: () => [
      const HomeState(status: PageStatus.loading),
      const HomeState(status: PageStatus.loading, isRefreshing: true),
      const HomeState(status: PageStatus.loading),
      const HomeState(status: PageStatus.success, content: _content),
    ],
    verify: (_) => verify(() => refresh(any())).called(1),
  );

  blocTest<HomeBloc, HomeState>(
    'marks content as empty when nothing is saved',
    build: build,
    act: (bloc) async {
      bloc.add(const HomeStarted());
      await Future<void>.delayed(Duration.zero);
      saved.add(const Right(_empty));
    },
    skip: 3,
    expect: () => [isA<HomeState>().having((state) => state.isEmpty, 'isEmpty', isTrue)],
  );

  blocTest<HomeBloc, HomeState>(
    'emits a blocking error when the local database cannot be read',
    build: build,
    act: (bloc) async {
      bloc.add(const HomeStarted());
      await Future<void>.delayed(Duration.zero);
      saved.add(const Left(_diskError));
    },
    skip: 3,
    expect: () => [
      isA<HomeState>()
          .having((state) => state.isBlockingError, 'isBlockingError', isTrue)
          .having((state) => state.failure, 'failure', _diskError),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'keeps the saved content on screen when a refresh fails',
    setUp: () => when(() => refresh(any())).thenAnswer((_) async => const Left(_offline)),
    build: build,
    seed: () => const HomeState(status: PageStatus.success, content: _content),
    act: (bloc) => bloc.add(const HomeRefreshRequested()),
    expect: () => [
      const HomeState(status: PageStatus.success, content: _content, isRefreshing: true),
      const HomeState(status: PageStatus.success, content: _content, refreshFailure: _offline),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'ignores a second pull-to-refresh while one is running',
    setUp: () =>
        when(() => refresh(any()))
            .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 50), () => const Right(unit))),
    build: build,
    act: (bloc) => bloc
      ..add(const HomeRefreshRequested())
      ..add(const HomeRefreshRequested()),
    wait: const Duration(milliseconds: 100),
    verify: (_) => verify(() => refresh(any())).called(1),
  );
}
