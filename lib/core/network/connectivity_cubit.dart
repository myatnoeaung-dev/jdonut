import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'network_info.dart';

enum ConnectivityStatus {
  unknown,
  online,
  offline;

  bool get isOffline => this == offline;
}

/// App-wide online/offline status: a network interface is up **and** the
/// internet answers (see [NetworkInfo]). Drives the offline banner, and pages
/// refresh when it turns back to online.
@lazySingleton
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit(this._networkInfo) : super(ConnectivityStatus.unknown);

  final NetworkInfo _networkInfo;
  StreamSubscription<bool>? _changes;

  /// Checks once now, then follows connectivity changes.
  Future<void> start() async {
    _changes ??= _networkInfo.onStatusChange.listen(_update);
    _update(await _networkInfo.isConnected);
  }

  void _update(bool isConnected) {
    if (isClosed) return;
    emit(isConnected ? ConnectivityStatus.online : ConnectivityStatus.offline);
  }

  @override
  Future<void> close() async {
    await _changes?.cancel();
    return super.close();
  }
}
