import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/hive/classes_extractor.dart' show extractClassesFromHive;
import '../data/key_value_store.dart';
import '../entities/classe.dart';
import '../features/dashboard/controller.dart';
import '../features/explorer/explorer.dart';
import '../features/settings/settings_controller.dart';
import '../repositories/classes_repository.dart';
import '../shared/classes_store.dart';
import 'app_info.dart';
import 'app_view.dart';

class ElpcdApp extends StatefulWidget {
  const ElpcdApp({super.key});

  @override
  State<ElpcdApp> createState() => _ElpcdAppState();
}

class _ElpcdAppState extends State<ElpcdApp> {
  late final ClassesRepository classesRepository;
  late final KeyValueStore settingsStore;

  bool isBootstrapping = true;

  @override
  void initState() {
    super.initState();
    bootstrap();
  }

  @override
  Widget build(BuildContext context) {
    if (isBootstrapping) return const SizedBox();

    return MultiProvider(
      providers: [
        Provider<ClassesRepository>.value(value: classesRepository),
        ChangeNotifierProvider(
          create: (_) => ClassesStore(repository: classesRepository),
        ),
        ChangeNotifierProvider(create: (_) => OpenClassNotifier()),
        Provider(create: (_) => ClassesTreeViewController()),
        Provider(
          create: (_) => DashboardController(),
          dispose: (_, controller) => controller.dispose(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsController(settingsStore),
        ),
      ],
      child: const ElpcdAppView(),
    );
  }

  Future<void> bootstrap() async {
    await setupDependencies();

    await migrateDataFromLegacyHiveDatabase();

    setupAppInfo();

    setState(() {
      isBootstrapping = false;
    });
  }

  Future<void> setupDependencies() async {
    classesRepository = InMemoryClassesRepository();
    settingsStore = InMemoryKeyValueStore();
  }

  Future<void> migrateDataFromLegacyHiveDatabase() async {
    final classes = await extractClassesFromHive();

    if (classes == null || classes.isEmpty) {
      return;
    }

    classesRepository.insertAll({
      for (final clazz in classes)
        if (clazz.id case final int classId?)
          classId: Classe(
            parentId: clazz.parentId,
            name: clazz.name,
            code: clazz.code,
            metadata: clazz.metadata,
          )..id = classId,
    });
  }
}
