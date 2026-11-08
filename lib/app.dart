import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'core/extensions/l10n_extension.dart';
import 'core/router/app_router.dart';
import 'core/session/auth_session.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class JDonutApp extends StatefulWidget {
  const JDonutApp({super.key, required this.session});

  final AuthSession session;

  @override
  State<JDonutApp> createState() => _JDonutAppState();
}

class _JDonutAppState extends State<JDonutApp> {
  late final GoRouter _router = createAppRouter(widget.session);

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
