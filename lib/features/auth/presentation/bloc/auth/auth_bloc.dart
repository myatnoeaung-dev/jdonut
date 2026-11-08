import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/log_out_use_case.dart';
import '../../../domain/usecases/restore_session_use_case.dart';
import '../../../domain/usecases/watch_session_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// App-wide signed-in state. The router guard and Settings read it; sign-in
/// and registration reach it through the repository's session stream.
@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._restoreSession, this._logOut, WatchSessionUseCase watchSession) : super(const AuthUnknown()) {
    on<AuthStarted>(_onStarted);
    on<_AuthSessionChanged>(_onSessionChanged);
    on<AuthLogOutRequested>(_onLogOutRequested, transformer: droppable());
    _sessionSubscription = watchSession().listen((user) => add(_AuthSessionChanged(user)));
  }

  final RestoreSessionUseCase _restoreSession;
  final LogOutUseCase _logOut;
  late final StreamSubscription<User?> _sessionSubscription;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final restored = await _restoreSession(const NoParams());
    emit(restored.fold((_) => const Unauthenticated(), _stateFor));
  }

  void _onSessionChanged(_AuthSessionChanged event, Emitter<AuthState> emit) => emit(_stateFor(event.user));

  Future<void> _onLogOutRequested(AuthLogOutRequested event, Emitter<AuthState> emit) async {
    await _logOut(const NoParams());
    emit(const Unauthenticated());
  }

  AuthState _stateFor(User? user) => user == null ? const Unauthenticated() : Authenticated(user);

  @override
  Future<void> close() async {
    await _sessionSubscription.cancel();
    return super.close();
  }
}
