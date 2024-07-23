import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/features/features.dart';
import 'src/repositories/hive_repository.dart';

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
