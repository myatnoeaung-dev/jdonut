import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/extensions/l10n_extension.dart';
import 'core/l10n/locale_controller.dart';
import 'core/network/connectivity_cubit.dart';
import 'core/router/app_router.dart';
import 'core/router/go_router_refresh_stream.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'l10n/app_localizations.dart';

class JDonutApp extends StatefulWidget {
  const JDonutApp({super.key, required this.authBloc, required this.connectivityCubit, required this.localeController});

  /// Already started (session restored) before the app is shown.
  final AuthBloc authBloc;

  /// Already started; drives the offline banner and refresh on reconnect.
  final ConnectivityCubit connectivityCubit;
  final LocaleController localeController;

  @override
  State<JDonutApp> createState() => _JDonutAppState();
}

class _JDonutAppState extends State<JDonutApp> {
  late final GoRouterRefreshStream _routerRefresh = GoRouterRefreshStream(widget.authBloc.stream);
  late final GoRouter _router = createAppRouter(authBloc: widget.authBloc, refresh: _routerRefresh);

  @override
  void dispose() {
    _router.dispose();
    _routerRefresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.authBloc),
        BlocProvider.value(value: widget.connectivityCubit),
      ],
      // Rebuilds with the new locale when the language is changed in Settings.
      child: ListenableBuilder(
        listenable: widget.localeController,
        builder: (context, _) => MaterialApp.router(
          onGenerateTitle: (context) => context.l10n.appTitle,
          theme: AppTheme.light,
          locale: widget.localeController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
