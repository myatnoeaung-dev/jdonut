import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Where the signed-in user's id is kept between app launches.
abstract interface class SessionStorage {
  Future<String?> readUserId();

  Future<void> saveUserId(String userId);

  Future<void> clear();
}

@LazySingleton(as: SessionStorage)
class SecureSessionStorage implements SessionStorage {
  const SecureSessionStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const String _userIdKey = 'session_user_id';

  @override
  Future<String?> readUserId() => _storage.read(key: _userIdKey);

  @override
  Future<void> saveUserId(String userId) => _storage.write(key: _userIdKey, value: userId);

  @override
  Future<void> clear() => _storage.delete(key: _userIdKey);
}

@module
abstract class StorageModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage =>
      const FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device));
}
