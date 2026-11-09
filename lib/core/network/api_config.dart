/// Where the app's API lives. Feature code only uses [ApiPaths].
abstract final class ApiConfig {
  static const String baseUrl = 'https://mock.jdonut.app';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  /// get_it name of the mock server's simulated network delay.
  static const String mockLatencyName = 'mockServerLatency';
  static const Duration mockLatency = Duration(milliseconds: 600);
}

abstract final class ApiPaths {
  static const String home = '/v1/home';
  static const String products = '/v1/products';
  static const String currentMember = '/v1/members/me';
}
