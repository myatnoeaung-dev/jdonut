import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/bloc/page_status.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/usecases/refresh_home_content_use_case.dart';
import '../../domain/usecases/watch_home_content_use_case.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

/// Home shows what is in the local database and refreshes it in the
/// background. A failed refresh never hides saved content.
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._watchHomeContent, this._refreshHomeContent) : super(const HomeState()) {
    on<HomeStarted>(_onStarted, transformer: restartable());
    on<HomeRefreshRequested>(_onRefreshRequested, transformer: droppable());
  }

  final WatchHomeContentUseCase _watchHomeContent;
  final RefreshHomeContentUseCase _refreshHomeContent;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: PageStatus.loading, failure: null));
    add(const HomeRefreshRequested());
    await emit.forEach(
      _watchHomeContent(const NoParams()),
      onData: (result) => result.match(
        (failure) => state.copyWith(status: PageStatus.error, failure: failure),
        (content) => state.copyWith(status: PageStatus.success, content: content, failure: null),
      ),
    );
  }

  Future<void> _onRefreshRequested(HomeRefreshRequested event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRefreshing: true, refreshFailure: null));
    final result = await _refreshHomeContent(const NoParams());
    emit(state.copyWith(isRefreshing: false, refreshFailure: result.getLeft().toNullable()));
  }
}
