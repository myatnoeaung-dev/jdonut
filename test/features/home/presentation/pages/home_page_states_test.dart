import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jdonut/core/bloc/page_status.dart';
import 'package:jdonut/core/di/injection_container.dart';
import 'package:jdonut/core/error/failure.dart';
import 'package:jdonut/core/network/connectivity_cubit.dart';
import 'package:jdonut/core/widgets/state_views.dart';
import 'package:jdonut/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:jdonut/features/home/domain/entities/home_content.dart';
import 'package:jdonut/features/home/presentation/bloc/home_bloc.dart';
import 'package:jdonut/features/home/presentation/pages/home_page.dart';
import 'package:jdonut/features/rewards/presentation/bloc/member/member_bloc.dart';
import 'package:jdonut/l10n/app_localizations.dart';

class _MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class _MockMemberBloc extends MockBloc<MemberEvent, MemberState> implements MemberBloc {}

class _MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class _MockConnectivityCubit extends MockCubit<ConnectivityStatus> implements ConnectivityCubit {}

void main() {
  late _MockHomeBloc homeBloc;

  setUpAll(() => registerFallbackValue(const HomeStarted()));

  setUp(() async {
    await getIt.reset();
    homeBloc = _MockHomeBloc();
    final memberBloc = _MockMemberBloc();
    when(() => memberBloc.state).thenReturn(const MemberState());
    getIt
      ..registerFactory<HomeBloc>(() => homeBloc)
      ..registerFactory<MemberBloc>(() => memberBloc);
  });

  Future<void> pumpHome(WidgetTester tester, HomeState state) async {
    when(() => homeBloc.state).thenReturn(state);
    final authBloc = _MockAuthBloc();
    when(() => authBloc.state).thenReturn(const Unauthenticated());
    final connectivity = _MockConnectivityCubit();
    when(() => connectivity.state).thenReturn(ConnectivityStatus.online);
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<ConnectivityCubit>.value(value: connectivity),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: HomePage()),
        ),
      ),
    );
  }

  testWidgets('shows a spinner on the first load', (tester) async {
    await pumpHome(tester, const HomeState(status: PageStatus.loading));

    expect(find.byKey(LoadingView.spinnerKey), findsOneWidget);
  });

  testWidgets('shows an error with Try again, which restarts Home', (tester) async {
    await pumpHome(tester, const HomeState(status: PageStatus.error, failure: CacheFailure(null, 'disk')));
    await tester.pump();

    expect(find.text('Something went wrong.'), findsOneWidget);
    clearInteractions(homeBloc); // the page already started the bloc once on open
    await tester.tap(find.text('Try again'));

    verify(() => homeBloc.add(const HomeStarted())).called(1);
  });

  testWidgets('shows the empty message with a refresh button when nothing is saved', (tester) async {
    const empty = HomeContent(banners: [], sections: [], shops: []);
    await pumpHome(tester, const HomeState(status: PageStatus.success, content: empty));
    await tester.pump();

    expect(find.text('No donuts to show yet.'), findsOneWidget);
    await tester.tap(find.text('Refresh'));

    verify(() => homeBloc.add(const HomeRefreshRequested())).called(1);
  });
}
