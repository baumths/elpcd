import 'package:flutter/material.dart';

import '/localizations.dart';
import 'router.dart';

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'ElpcdApp',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (BuildContext context) => context.l10n.shortAppTitle,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      routerConfig: AppRouter.config,
    );
  }
}
