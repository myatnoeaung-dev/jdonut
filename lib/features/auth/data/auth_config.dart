import 'package:injectable/injectable.dart';

/// Settings of the fake auth backend.
abstract final class AuthConfig {
  /// get_it name of the simulated network delay (tests register `Duration.zero`).
  static const String fakeLatencyName = 'fakeAuthLatency';
  static const Duration fakeLatency = Duration(seconds: 1);

  /// The only code the fake backend accepts.
  static const String fakeOtpCode = '123456';
  static const int maxOtpAttempts = 3;
}

@module
abstract class AuthDataModule {
  @Named(AuthConfig.fakeLatencyName)
  Duration get fakeAuthLatency => AuthConfig.fakeLatency;
}
