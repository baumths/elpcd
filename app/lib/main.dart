import 'package:flutter/material.dart';

void main() => runApp(const ElpcdApp());

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const Scaffold(),
    );
  }
}
