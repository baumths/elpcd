import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../features/home/home.dart';
import '../features/settings/settings_controller.dart';
import 'app_theme.dart';
import 'navigator.dart';

class ElPCDApp extends StatelessWidget {
  const ElPCDApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.select<SettingsController, bool>(
      (controller) => controller.darkMode,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(darkMode: darkMode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      navigatorKey: navigatorKey,
      home: const HomeView(),
    );
  }
}
