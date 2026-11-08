import 'package:jdonut/core/storage/session_storage.dart';

/// Session storage for tests: no platform channel, forgets everything on reset.
class InMemorySessionStorage implements SessionStorage {
  String? _userId;

  @override
  Future<String?> readUserId() async => _userId;

  @override
  Future<void> saveUserId(String userId) async => _userId = userId;

  @override
  Future<void> clear() async => _userId = null;
}
