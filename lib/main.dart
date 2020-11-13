import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app/app.dart';
import 'src/database/hive_database.dart';
import 'src/home/home.dart';

void main() async {
  await HiveDatabase.instance.initDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => TreeviewController()),
      ],
      child: ElPCDApp(),
    ),
  );
}
