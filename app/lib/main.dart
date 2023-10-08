import 'package:flutter/material.dart';

void main() => runApp(const ElpcdApp());

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElPCD',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
      home: const Scaffold(),
    );
  }
}
