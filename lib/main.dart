import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'features/app/app.dart';
import 'features/home/home_controller.dart';
import 'features/home/widgets/tree_view.dart';
import 'features/settings/settings_controller.dart';
import 'repositories/hive_repository.dart';

Future<void> main() async {
  final repository = HiveRepository();
  await repository.initDatabase();

  final settingsBox = await Hive.openBox<Object>('settings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => TreeviewController()),
        ChangeNotifierProvider(
          create: (_) => SettingsController(settingsBox),
        ),
        RepositoryProvider.value(value: repository),
      ],
      child: const ElPCDApp(),
    ),
  );
}
