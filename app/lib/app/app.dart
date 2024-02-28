import 'package:flutter/material.dart';

import '/localization.dart';

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(
          child: Text('ElPCD'),
        ),
      ),
    );
  }
}
