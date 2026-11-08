import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StorageModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
  );
}

@injectable
class StoregeUtil {
  // Initialize FlutterSecureStorage
  final FlutterSecureStorage _secureStorage;

  StoregeUtil(this._secureStorage);
  // Keys
  static const String _authSession = 'auth_session';

  Future<void> saveAuthSession(String session) async {
    await _secureStorage.write(key: _authSession, value: session);
  }

  Future<String?> getAuthSession() async {
    return await _secureStorage.read(key: _authSession);
  }

  Future<void> deleteAuthSession() async {
    await _secureStorage.delete(key: _authSession);
  }

  /// Ends the active session (on logout) but keeps the last account.
  Future<void> clearSession() async {
    await Future.wait([deleteAuthSession()]);
  }

  // Clear all, including the last account
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
