import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/registration_draft.dart';
import '../models/user_model.dart';

/// Registered users in the local Drift database.
abstract interface class AuthLocalDatasource {
  Future<UserModel?> findByPhone(String phoneNumber);

  Future<UserModel?> findById(int id);

  Future<UserModel> insertUser(RegistrationDraft draft);
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  const AuthLocalDatasourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<UserModel?> findByPhone(String phoneNumber) => _guard(() async {
    final query = _database.select(_database.users)..where((user) => user.phoneNumber.equals(phoneNumber));
    final row = await query.getSingleOrNull();
    return row == null ? null : UserModel.fromRow(row);
  });

  @override
  Future<UserModel?> findById(int id) => _guard(() async {
    final query = _database.select(_database.users)..where((user) => user.id.equals(id));
    final row = await query.getSingleOrNull();
    return row == null ? null : UserModel.fromRow(row);
  });

  @override
  Future<UserModel> insertUser(RegistrationDraft draft) => _guard(() async {
    final row = await _database.into(_database.users).insertReturning(UserModel.companionFor(draft));
    return UserModel.fromRow(row);
  });

  /// Maps database exceptions to [CacheFailure].
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on Exception catch (error) {
      throw CacheFailure('Local database error', '$error');
    }
  }
}
