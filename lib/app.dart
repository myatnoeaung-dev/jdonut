import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'core/extensions/l10n_extension.dart';
import 'core/l10n/locale_controller.dart';
import 'core/router/app_router.dart';
import 'core/session/auth_session.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class JDonutApp extends StatefulWidget {
  const JDonutApp({super.key, required this.session, required this.localeController});

  final AuthSession session;
  final LocaleController localeController;

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
    // Rebuilds with the new locale when the language is changed in Settings.
    return ListenableBuilder(
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
    );
  }
}
