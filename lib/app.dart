import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/design_tokens.dart';
import 'l10n/app_localizations.dart';

class EcclesiasApp extends StatelessWidget {
  const EcclesiasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: DesignTokens.light(),
      darkTheme: DesignTokens.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter,
    );
  }
}
