import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../models/pcd_model.dart';

class HiveDatabase {
  final String hiveBoxesDirectoryName = '.elpcd_database';
  static const String settingsBox = 'settings';
  static const String pcdBox = 'pcd';
  // Singleton
  HiveDatabase._privateConstructor();
  static HiveDatabase instance = HiveDatabase._privateConstructor();

  Future<void> initDatabase() async {
    // Initializing Hive
    await Hive.initFlutter(this.hiveBoxesDirectoryName);

    // Registering adapters
    Hive.registerAdapter<PCDModel>(PCDModelAdapter());

    // Opening settings box
    await Hive.openBox(HiveDatabase.settingsBox);

    // Opening PCD box
    await Hive.openBox<PCDModel>(HiveDatabase.pcdBox);
  }
}
