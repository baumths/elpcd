import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/app/app.dart';
import 'features/home/home_controller.dart';
import 'features/home/widgets/tree/treeview.dart';
import 'repositories/hive_repository.dart';

Future<void> main() async {
  final repository = HiveRepository();
  await repository.initDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => TreeviewController()),
        RepositoryProvider.value(value: repository),
      ],
      child: const ElPCDApp(),
    ),
  );
}
