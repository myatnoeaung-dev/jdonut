import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:jdonut/core/network/network_info.dart';

/// Reads assets straight from the project folder, synchronously, so seeding
/// and the mock server work inside a widget test's fake-time zone.
class FileAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) async => ByteData.sublistView(File(key).readAsBytesSync());

  @override
  Future<String> loadString(String key, {bool cache = true}) async => File(key).readAsStringSync();
}

/// Online or offline on demand; [goOnline]/[goOffline] also announce the change.
class FakeNetworkInfo implements NetworkInfo {
  FakeNetworkInfo({this.isOnline = true});

  bool isOnline;
  final StreamController<bool> _changes = StreamController<bool>.broadcast();

  @override
  Future<bool> get isConnected async => isOnline;

  @override
  Stream<bool> get onStatusChange => _changes.stream;

  void goOnline() => _set(true);

  void goOffline() => _set(false);

  void _set(bool isOnline) {
    this.isOnline = isOnline;
    _changes.add(isOnline);
  }
}
