import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// import 'src/database/hive_database.dart';
import 'src/features/features.dart';
import 'src/repositories/hive_repository.dart';

Future<void> main() async {
  // await HiveDatabase.instance.initDatabase();
  final HiveRepository repository = HiveRepository()..initDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => TreeviewController()),
        RepositoryProvider.value(value: repository),
      ],
      child: ElPCDApp(),
    ),
  );
}
