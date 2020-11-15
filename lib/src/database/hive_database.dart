import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/pcd_model.dart';

class HiveDatabase {
  final String hiveBoxesDirectoryName = '.elpcd_database';
  static const String settingsBoxName = 'settings';
  static const String pcdBoxName = 'pcd';

  static Box<PCDModel> pcdBox;
  static Box<dynamic> settingsBox;

  // Singleton
  HiveDatabase._privateConstructor();
  static HiveDatabase instance = HiveDatabase._privateConstructor();

  Future<void> initDatabase() async {
    // Initializing Hive
    await Hive.initFlutter(hiveBoxesDirectoryName);

    // Registering adapters
    Hive.registerAdapter<PCDModel>(PCDModelAdapter());

    // Opening settings box
    settingsBox = await Hive.openBox<dynamic>(HiveDatabase.settingsBoxName);

    // Opening PCD box
    pcdBox = await Hive.openBox<PCDModel>(HiveDatabase.pcdBoxName);
  }

  /// Inserts a class and assigns an auto-incremented `legacyId` to it
  static Future<void> insertClass(PCDModel pcd) async {
    final int id = await HiveDatabase.pcdBox.add(pcd);
    pcd.legacyId = id;
    await pcd.save();
  }

  /// Returns children of `legacyId`, if `legacyId` is null, returns roots.
  static List<PCDModel> getClasses({int legacyId = -1}) {
    if (HiveDatabase.pcdBox.isEmpty) return [];
    final List<PCDModel> entries = HiveDatabase.pcdBox.values
        .where((pcd) => pcd.parentId == legacyId)
        .toList();
    entries.sort((a, b) => a.codigo.compareTo(b.codigo));
    return entries ?? [];
  }

  /// Verifies if given `legacyId` has children classes
  static bool hasChildren(int legacyId) {
    if (HiveDatabase.pcdBox.isEmpty) return false;
    final child = HiveDatabase.pcdBox.values.firstWhere(
      (pcd) => pcd.parentId == legacyId,
      orElse: () => null,
    );
    if (child == null) return false;
    return true;
  }

  /// Recursively build Classes' identifiers
  static String buildIdentifier(PCDModel pcd) {
    if (pcd.parentId == -1) {
      final Box settingsBox = HiveDatabase.settingsBox;
      final String codearq = settingsBox.get(
        'codearq',
        defaultValue: 'ElPCD',
      ) as String;
      return '$codearq ${pcd.codigo}';
    }
    final parent = HiveDatabase.pcdBox.values.firstWhere(
      (i) => i.legacyId == pcd.parentId,
      orElse: () => null,
    );
    return '${buildIdentifier(parent)}-${pcd.codigo ?? ""}';
  }
}
