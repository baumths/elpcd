import 'package:flutter/material.dart';

class ElpcdApp extends StatelessWidget {
  const ElpcdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('ElPCD'),
        ),
      ),
    );
  }
}
