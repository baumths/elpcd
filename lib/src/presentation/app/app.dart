import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ElPCD',
      theme: kLightTheme,
      home: const Scaffold(),
    );
  }
}
