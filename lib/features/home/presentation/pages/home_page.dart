import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/network/connectivity_cubit.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../rewards/presentation/bloc/member/member_bloc.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_content_view.dart';
import '../widgets/home_skeleton.dart';

/// Home tab. Everything comes from the local database, so it works offline;
/// it refreshes in the background on open, on pull-to-refresh and when the
/// connection comes back.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Key of a product card, for tests.
  static Key productCardKey(String productId) => HomeContentView.productCardKey(productId);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeBloc>()..add(const HomeStarted())),
        BlocProvider(create: (_) => getIt<MemberBloc>()..add(const MemberStarted())),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityCubit, ConnectivityStatus>(
          listenWhen: (previous, current) => previous.isOffline && current == ConnectivityStatus.online,
          listener: (context, _) => context.read<HomeBloc>().add(const HomeRefreshRequested()),
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              current.refreshFailure != null && previous.refreshFailure != current.refreshFailure,
          listener: (context, _) => _showRefreshFailed(context),
        ),
      ],
      child: ColoredBox(
        color: context.palette.pageBackground,
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.content != current.content ||
              previous.isFirstLoad != current.isFirstLoad ||
              previous.isBlockingError != current.isBlockingError,
          // Cross-fades between skeleton, content, error and empty.
          builder: (context, state) => AnimatedSwitcher(
            duration: context.motion(AppDurations.entrance),
            child: KeyedSubtree(key: ValueKey(_bodyKind(state)), child: _buildBody(context, state)),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    final bloc = context.read<HomeBloc>();
    final content = state.content;
    if (state.isFirstLoad) return const HomeSkeleton();
    if (content == null) return ErrorView(onRetry: () => bloc.add(const HomeStarted()));
    if (content.isEmpty) {
      return EmptyView(
        message: context.l10n.homeEmpty,
        actionLabel: context.l10n.refresh,
        onAction: () => bloc.add(const HomeRefreshRequested()),
      );
    }
    return HomeContentView(content: content, onRefresh: () => _refresh(bloc));
  }

  /// Which of the four bodies [state] shows; changing it runs the cross-fade.
  static int _bodyKind(HomeState state) => switch (state) {
    _ when state.isFirstLoad => 0,
    _ when state.content == null => 1,
    _ when state.content!.isEmpty => 2,
    _ => 3,
  };

  /// Completes when the refresh ends, so the pull-to-refresh spinner hides then.
  Future<void> _refresh(HomeBloc bloc) {
    bloc.add(const HomeRefreshRequested());
    return bloc.stream.firstWhere((state) => !state.isRefreshing);
  }

  void _showRefreshFailed(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.refreshFailed)));
  }
}
