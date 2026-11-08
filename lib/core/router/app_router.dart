import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../features/auth/presentation/pages/birth_date_page.dart';
import '../../features/auth/presentation/pages/name_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/phone_number_page.dart';
import '../../features/auth/presentation/pages/verify_otp_page.dart';
import '../../features/auth/presentation/widgets/auth_flow_scope.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/welcome_page.dart';
import '../../features/product/presentation/pages/product_detail_page.dart';
import '../../features/rewards/presentation/pages/rewards_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../l10n/app_localizations.dart';
import '../extensions/l10n_extension.dart';
import '../widgets/coming_soon_page.dart';
import 'app_routes.dart';
import 'app_shell.dart';

/// [refresh] re-runs the guard whenever [authBloc] changes (sign in / out).
GoRouter createAppRouter({required AuthBloc authBloc, required Listenable refresh}) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    refreshListenable: refresh,
    redirect: (context, state) => _authGuard(authBloc.state, state),
    routes: [
      GoRoute(path: AppRoutes.onboarding, builder: (_, _) => const OnboardingPage()),
      _authFlowRoute,
      _welcomeRoute,
      _tabsRoute,
      _productRoute,
    ],
  );
}

/// Signed out → only public routes. Signed in → never back to onboarding/login.
String? _authGuard(AuthState auth, GoRouterState state) {
  final location = state.matchedLocation;
  final isSignedIn = auth is Authenticated;
  if (!isSignedIn && !AppRoutes.isPublic(location)) return AppRoutes.onboarding;
  if (isSignedIn && AppRoutes.isSignedOutOnly(location)) return AppRoutes.home;
  return null;
}

/// Phone → OTP → name → date of birth share one [AuthFlowScope], so the step
/// blocs (and what was typed) survive Back until the flow ends.
final RouteBase _authFlowRoute = ShellRoute(
  builder: (_, state, child) =>
      AuthFlowScope(initialFlow: AuthFlow.fromQuery(state.uri.queryParameters[AppRouteParams.flow]), child: child),
  routes: [
    GoRoute(path: AppRoutes.phone, builder: (_, _) => const PhoneNumberPage()),
    GoRoute(path: AppRoutes.otp, builder: (_, _) => const VerifyOtpPage()),
    GoRoute(path: AppRoutes.name, builder: (_, _) => const NamePage()),
    GoRoute(path: AppRoutes.birthDate, builder: (_, _) => const BirthDatePage()),
  ],
);

final RouteBase _welcomeRoute = GoRoute(path: AppRoutes.welcome, builder: (_, _) => const WelcomePage());

final RouteBase _tabsRoute = StatefulShellRoute.indexedStack(
  builder: (_, _, navigationShell) => AppShell(navigationShell: navigationShell),
  branches: [
    _tab(AppRoutes.home, (_) => const HomePage()),
    _tab(AppRoutes.rewards, (_) => const RewardsPage()),
    _tab(AppRoutes.menu, (context) => _placeholder(context, (l10n) => l10n.navMenu)),
    _tab(AppRoutes.wallet, (context) => _placeholder(context, (l10n) => l10n.navWallet)),
    _tab(AppRoutes.settings, (_) => const SettingsPage()),
  ],
);

StatefulShellBranch _tab(String path, WidgetBuilder page) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, _) => page(context))],
);

/// Tabs whose screens aren't designed yet.
Widget _placeholder(BuildContext context, String Function(AppLocalizations l10n) title) =>
    ComingSoonPage(title: title(context.l10n));

final RouteBase _productRoute = GoRoute(
  path: AppRoutes.product,
  builder: (_, state) => ProductDetailPage(productId: state.pathParameters[AppRouteParams.id] ?? ''),
);
