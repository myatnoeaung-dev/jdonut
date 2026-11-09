part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(PageStatus.initial) PageStatus status,

    /// Kept while reloading or after an error, so saved content stays on screen.
    HomeContent? content,

    /// Reading the local database failed.
    Failure? failure,
    @Default(false) bool isRefreshing,

    /// The last background refresh failed; shown as a small message only.
    Failure? refreshFailure,
  }) = _HomeState;

  const HomeState._();

  bool get hasContent => content != null;

  /// Nothing saved yet and the first read hasn't finished.
  bool get isFirstLoad => content == null && (status == PageStatus.initial || status == PageStatus.loading);

  /// Nothing to show because the local read failed.
  bool get isBlockingError => content == null && status == PageStatus.error;

  bool get isEmpty => content?.isEmpty ?? false;
}
