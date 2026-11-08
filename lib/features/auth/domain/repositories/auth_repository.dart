import 'package:fpdart/fpdart.dart';

import '../../../../core/error/result.dart';
import '../entities/registration_draft.dart';
import '../entities/user.dart';

/// Phone-number sign-in. The app ships a fake implementation; a real API can
/// replace it without touching the UI.
abstract interface class AuthRepository {
  /// Emits the signed-in user after log in / registration, and null after log out.
  Stream<User?> get sessionChanges;

  /// The user saved from a previous launch, or null when signed out.
  Future<Result<User?>> restoreSession();

  Future<Result<bool>> isPhoneRegistered(String phoneNumber);

  /// Sends a fresh code and unlocks entry after too many wrong codes.
  Future<Result<Unit>> sendOtp(String phoneNumber);

  /// Fails with `InvalidOtpFailure` or `OtpLockedFailure`.
  Future<Result<Unit>> verifyOtp({required String phoneNumber, required String code});

  /// Fails with `NotRegisteredFailure` for unknown numbers.
  Future<Result<User>> logIn(String phoneNumber);

  /// Fails with `AlreadyRegisteredFailure` when the number has an account.
  Future<Result<User>> register(RegistrationDraft draft);

  Future<Result<Unit>> logOut();
}
