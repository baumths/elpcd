import 'package:elpcd/data/repositories/entities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_service/storage_service.dart';

import '/localizations.dart';
import 'router.dart';

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({
    super.key,
    required this.storageFacade,
  });

  final StorageFacade storageFacade;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: storageFacade),
        Provider<EntitiesRepository>(
          create: (_) => EntitiesRepository(
            edgesCollection: storageFacade.edgesCollection,
            entitiesCollection: storageFacade.entitiesCollection,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'ElpcdApp',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (BuildContext context) => context.l10n.shortAppTitle,
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        routerConfig: AppRouter.config,
      ),
    );
  }
}
