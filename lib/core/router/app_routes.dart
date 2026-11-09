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
  static const String menu = '/menu';
  static const String wallet = '/wallet';
  static const String settings = '/settings';
  static const String product = '/product/:${AppRouteParams.id}';

  /// [heroTag] names the image the detail page's photo flies from.
  static String productDetail(String id, {String? heroTag}) =>
      Uri(path: '/product/$id', queryParameters: heroTag == null ? null : {AppRouteParams.hero: heroTag}).toString();

  static String phoneFor(AuthFlow flow) =>
      Uri(path: phone, queryParameters: {AppRouteParams.flow: flow.name}).toString();

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
  static const String hero = 'hero';
}

/// Whether the phone + OTP steps are creating an account or logging in.
enum AuthFlow {
  register,
  login;

  static AuthFlow fromQuery(String? value) =>
      AuthFlow.values.firstWhere((flow) => flow.name == value, orElse: () => AuthFlow.register);
}
