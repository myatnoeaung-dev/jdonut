import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  /// True only when a network interface is up **and** the internet is reachable.
  Future<bool> get isConnected;

  /// Emits whenever reachability changes (e.g. to trigger a background refresh).
  Stream<bool> get onStatusChange;
}

@module
abstract class ConnectivityModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  static const String reachabilityHost = 'one.one.one.one';
  static const Duration reachabilityTimeout = Duration(seconds: 5);

  @override
  Future<bool> get isConnected async {
    final interfaces = await _connectivity.checkConnectivity();
    if (_hasNoInterface(interfaces)) return false;
    return _canReachInternet();
  }

  @override
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.asyncMap((_) => isConnected).distinct();

  bool _hasNoInterface(List<ConnectivityResult> results) =>
      results.every((result) => result == ConnectivityResult.none);

  /// Being on Wi-Fi doesn't mean the internet works, so do a real DNS lookup.
  Future<bool> _canReachInternet() async {
    // dart:io lookups are unavailable on web; let the request itself fail there.
    if (kIsWeb) return true;
    try {
      final addresses = await InternetAddress.lookup(reachabilityHost).timeout(reachabilityTimeout);
      return addresses.isNotEmpty && addresses.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }
}
