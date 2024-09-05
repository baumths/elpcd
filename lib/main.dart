import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'entities/classe.dart';
import 'features/home/tree_view.dart';
import 'features/settings/settings_controller.dart';
import 'repositories/classes_repository.dart';
import 'shared/classes_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    Hive.init('.elpcd_database');
  }

  Hive.registerAdapter<Classe>(ClasseAdapter());

  final classesBox = await Hive.openBox<Classe>('classes');
  final settingsBox = await Hive.openBox<Object>('settings');

  runApp(
    MultiProvider(
      providers: [
        Provider(lazy: false, create: (_) => ClassesRepository(classesBox)),
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
