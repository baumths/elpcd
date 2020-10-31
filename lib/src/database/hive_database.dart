import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

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
    await Hive.initFlutter(this.hiveBoxesDirectoryName);

    // Registering adapters
    Hive.registerAdapter<PCDModel>(PCDModelAdapter());

    // Opening settings box
    HiveDatabase.settingsBox = await Hive.openBox(HiveDatabase.settingsBoxName);

    // Opening PCD box
    HiveDatabase.pcdBox = await Hive.openBox<PCDModel>(HiveDatabase.pcdBoxName);
  }

  static Future<void> insertPCD(PCDModel pcd) async {
    int id = await HiveDatabase.pcdBox.add(pcd);
    pcd.legacyId = id;
    await pcd.save();
  }

  /// Returns children of `parent`, if `parent` is null, returns roots.
  static List<PCDModel> getChildren({PCDModel parent}) {
    if (HiveDatabase.pcdBox.isEmpty) return [];
    final int parentId = parent?.legacyId ?? -1;
    List<PCDModel> entries = HiveDatabase.pcdBox.values
        .where((pcd) => pcd.parentId == parentId)
        .toList();
    entries.sort((a, b) => a.codigo.compareTo(b.codigo));
    return entries ?? [];
  }

  static bool hasChildren(PCDModel parent) {
    if (HiveDatabase.pcdBox.isEmpty) return false;
    final Box<PCDModel> pcdBox = HiveDatabase.pcdBox;
    final child = pcdBox.values.firstWhere(
      (pcd) => pcd.parentId == parent.legacyId,
      orElse: () => null,
    );
    return child == null ? false : true;
  }

  static String buildIdentifier(PCDModel pcd) {
    if (pcd.parentId == -1) {
      final Box settingsBox = HiveDatabase.settingsBox;
      final String codearq = settingsBox.get('codearq', defaultValue: 'ElPCD');
      return '$codearq ${pcd.codigo}';
    }
    final Box<PCDModel> pcdBox = HiveDatabase.pcdBox;
    final parent = pcdBox.values.firstWhere(
      (i) => i.legacyId == pcd.parentId,
      orElse: () => null,
    );
    return '${buildIdentifier(parent)}-${pcd.codigo ?? ""}';
  }
}
