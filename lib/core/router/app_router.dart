import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/birth_date_page.dart';
import '../../features/auth/presentation/pages/name_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/phone_number_page.dart';
import '../../features/auth/presentation/pages/verify_otp_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/welcome_page.dart';
import '../../features/product/presentation/pages/product_detail_page.dart';
import '../../features/rewards/presentation/pages/rewards_page.dart';
import '../session/auth_session.dart';
import 'app_routes.dart';
import 'app_shell.dart';

GoRouter createAppRouter(AuthSession session) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    refreshListenable: session,
    redirect: (context, state) => _authGuard(session, state),
    routes: [..._authRoutes, ..._registrationRoutes, _shellRoute, _productRoute],
  );
}

/// Signed out → only public routes. Signed in → never back to onboarding/login.
String? _authGuard(AuthSession session, GoRouterState state) {
  final location = state.matchedLocation;
  if (!session.isSignedIn && !AppRoutes.isPublic(location)) return AppRoutes.onboarding;
  if (session.isSignedIn && AppRoutes.isSignedOutOnly(location)) return AppRoutes.home;
  return null;
}

AuthFlow _flowOf(GoRouterState state) => AuthFlow.fromQuery(state.uri.queryParameters[AppRouteParams.flow]);

final List<RouteBase> _authRoutes = [
  GoRoute(path: AppRoutes.onboarding, builder: (_, _) => const OnboardingPage()),
  GoRoute(path: AppRoutes.phone, builder: (_, state) => PhoneNumberPage(flow: _flowOf(state))),
  GoRoute(
    path: AppRoutes.otp,
    builder: (_, state) => VerifyOtpPage(
      flow: _flowOf(state),
      phoneNumber: state.uri.queryParameters[AppRouteParams.phone] ?? '',
    ),
  ),
];

final List<RouteBase> _registrationRoutes = [
  GoRoute(path: AppRoutes.name, builder: (_, _) => const NamePage()),
  GoRoute(path: AppRoutes.birthDate, builder: (_, _) => const BirthDatePage()),
  GoRoute(path: AppRoutes.welcome, builder: (_, _) => const WelcomePage()),
];

final RouteBase _shellRoute = StatefulShellRoute.indexedStack(
  builder: (_, _, navigationShell) => AppShell(navigationShell: navigationShell),
  branches: [
    StatefulShellBranch(routes: [GoRoute(path: AppRoutes.home, builder: (_, _) => const HomePage())]),
    StatefulShellBranch(routes: [GoRoute(path: AppRoutes.rewards, builder: (_, _) => const RewardsPage())]),
  ],
);

final RouteBase _productRoute = GoRoute(
  path: AppRoutes.product,
  builder: (_, state) => ProductDetailPage(productId: state.pathParameters[AppRouteParams.id] ?? ''),
);
