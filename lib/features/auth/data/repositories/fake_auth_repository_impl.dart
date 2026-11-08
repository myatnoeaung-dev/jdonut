import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/result.dart';
import '../../../../core/repositories/base_repostitory.dart';
import '../../../../core/storage/session_storage.dart';
import '../../domain/entities/registration_draft.dart';
import '../../domain/entities/user.dart';
import '../../domain/failures/auth_failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../auth_config.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

/// Pretend backend: waits [AuthConfig.fakeLatency] like a network call, keeps
/// users in Drift and the session in secure storage. Accepts only
/// [AuthConfig.fakeOtpCode] and locks after [AuthConfig.maxOtpAttempts] wrong codes.
@LazySingleton(as: AuthRepository)
class FakeAuthRepositoryImpl extends BaseRepository implements AuthRepository {
  FakeAuthRepositoryImpl(
    this._users,
    this._session,
    @Named(AuthConfig.fakeLatencyName) this._latency, {
    required super.networkInfo,
  });

  final AuthLocalDatasource _users;
  final SessionStorage _session;
  final Duration _latency;

  final StreamController<User?> _sessionChanges = StreamController<User?>.broadcast();

  /// Wrong codes entered per phone number since the last code was sent.
  final Map<String, int> _wrongCodes = {};

  @override
  Stream<User?> get sessionChanges => _sessionChanges.stream;

  @override
  Future<Result<User?>> restoreSession() => guard(() async {
    final savedId = await _session.readUserId();
    final userId = savedId == null ? null : int.tryParse(savedId);
    final user = userId == null ? null : await _users.findById(userId);
    if (user == null && savedId != null) await _session.clear();
    return user?.toEntity();
  });

  @override
  Future<Result<bool>> isPhoneRegistered(String phoneNumber) => guard(() async {
    await _simulateNetwork();
    return await _users.findByPhone(phoneNumber) != null;
  });

  @override
  Future<Result<Unit>> sendOtp(String phoneNumber) => guard(() async {
    await _simulateNetwork();
    _wrongCodes.remove(phoneNumber);
    return unit;
  });

  @override
  Future<Result<Unit>> verifyOtp({required String phoneNumber, required String code}) => guard(() async {
    await _simulateNetwork();
    _checkCode(phoneNumber, code);
    return unit;
  });

  @override
  Future<Result<User>> logIn(String phoneNumber) => guard(() async {
    await _simulateNetwork();
    final user = await _users.findByPhone(phoneNumber);
    if (user == null) throw const NotRegisteredFailure();
    return _startSession(user);
  });

  @override
  Future<Result<User>> register(RegistrationDraft draft) => guard(() async {
    await _simulateNetwork();
    if (await _users.findByPhone(draft.phoneNumber) != null) throw const AlreadyRegisteredFailure();
    return _startSession(await _users.insertUser(draft));
  });

  @override
  Future<Result<Unit>> logOut() => guard(() async {
    await _session.clear();
    _sessionChanges.add(null);
    return unit;
  });

  /// Throws [OtpLockedFailure] or [InvalidOtpFailure] unless [code] is right.
  void _checkCode(String phoneNumber, String code) {
    final wrongSoFar = _wrongCodes[phoneNumber] ?? 0;
    if (wrongSoFar >= AuthConfig.maxOtpAttempts) throw const OtpLockedFailure();
    if (code == AuthConfig.fakeOtpCode) {
      _wrongCodes.remove(phoneNumber);
      return;
    }
    final wrongNow = wrongSoFar + 1;
    _wrongCodes[phoneNumber] = wrongNow;
    if (wrongNow >= AuthConfig.maxOtpAttempts) throw const OtpLockedFailure();
    throw InvalidOtpFailure(AuthConfig.maxOtpAttempts - wrongNow);
  }

  Future<User> _startSession(UserModel model) async {
    await _session.saveUserId('${model.id}');
    final user = model.toEntity();
    _sessionChanges.add(user);
    return user;
  }

  Future<void> _simulateNetwork() async {
    if (_latency > Duration.zero) await Future<void>.delayed(_latency);
  }
}
