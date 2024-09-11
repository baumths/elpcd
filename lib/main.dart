import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'features/explorer/explorer.dart';
import 'features/settings/settings_controller.dart';
import 'repositories/classes_repository.dart';
import 'shared/classes_store.dart';
import 'sqlite3/sqlite3.dart' show openSqliteDatabase;

Future<void> main() async {
  await Hive.initFlutter('.elpcd_database');
  final settingsBox = await Hive.openBox<Object>('settings');

  final sqliteDatabase = await openSqliteDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: SqliteClassesRepository(sqliteDatabase)),
        ChangeNotifierProvider(
          create: (context) => ClassesStore(
            repository: context.read<ClassesRepository>(),
          ),
        ),
        Provider(create: (_) => ClassesTreeViewController()),
        ChangeNotifierProvider(create: (_) => SettingsController(settingsBox)),
      ],
      child: const ElPCDApp(),
    ),
  );
}
