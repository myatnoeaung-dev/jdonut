part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Start (or restart, after an error) showing Home; also refreshes once in the background.
final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

/// Pull-to-refresh, or the connection came back. Ignored while a refresh is running.
final class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}
