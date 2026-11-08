/// Route paths and query keys used with go_router.
abstract final class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String phone = '/auth/phone';
  static const String otp = '/auth/otp';
  static const String name = '/register/name';
  static const String birthDate = '/register/birth-date';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String rewards = '/rewards';
  static const String product = '/product/:${AppRouteParams.id}';

  static String productDetail(String id) => '/product/$id';

  static String phoneFor(AuthFlow flow) => Uri(path: phone, queryParameters: {AppRouteParams.flow: flow.name}).toString();

  static String otpFor(AuthFlow flow, String phoneNumber) => Uri(
        path: otp,
        queryParameters: {AppRouteParams.flow: flow.name, AppRouteParams.phone: phoneNumber},
      ).toString();

  /// Only reachable while signed out; a signed-in user is sent home.
  static const List<String> _signedOutOnlyPrefixes = [onboarding, '/auth'];

  /// Registration profile steps; reachable signed in or out.
  static const String _registrationPrefix = '/register';

  static bool isSignedOutOnly(String location) => _signedOutOnlyPrefixes.any(location.startsWith);

  static bool isPublic(String location) => isSignedOutOnly(location) || location.startsWith(_registrationPrefix);
}

abstract final class AppRouteParams {
  static const String id = 'id';
  static const String flow = 'flow';
  static const String phone = 'phone';
}

/// Whether the phone + OTP steps are creating an account or logging in.
enum AuthFlow {
  register,
  login;

  static AuthFlow fromQuery(String? value) =>
      AuthFlow.values.firstWhere((flow) => flow.name == value, orElse: () => AuthFlow.register);
}
