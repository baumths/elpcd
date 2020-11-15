import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../entities/entities.dart';

class HiveDb {
  final boxesDirectoryName = '.elpcd_database';
  final settingsBoxName = 'settings';
  final classesBoxName = 'classes';

  // Singleton
  HiveDb._privateConstructor();
  static HiveDb instance = HiveDb._privateConstructor();

  Future<void> initDatabase() async {
    await Hive.initFlutter(boxesDirectoryName);

    Hive.registerAdapter<Classe>(ClasseAdapter());

    await Hive.openBox<dynamic>(settingsBoxName);
    await Hive.openBox<Classe>(classesBoxName);
  }

  Box<Classe> get classesBox => Hive.box(classesBoxName);
  Box<dynamic> get settingsBox => Hive.box(settingsBoxName);

  bool get isDarkMode =>
      settingsBox.get('darkMode', defaultValue: true) as bool;
  String get codearq =>
      settingsBox.get('codearq', defaultValue: 'ElPCD') as String;

  bool hasChildren(int parent) {
    final child = classesBox.values.firstWhere(
      (classe) => classe.parentId == parent,
      orElse: () => null,
    );
    if (child == null) return false;
    return true;
  }

  List<Classe> getChildren(int parent) {
    final children =
        classesBox.values.where((classe) => classe.parentId == parent).toList();

    children.sort((a, b) => a.code.compareTo(b.code));
    return children;
  }

  List<Classe> getAllEntries() => classesBox.values.toList();

  Classe getEntryById(int id) => classesBox.get(id);

  Future<void> insert(Classe classe) async {
    final bool isNewClasse = !classesBox.containsKey(classe.id);
    if (isNewClasse) {
      final int id = await classesBox.add(classe);
      classe.id = id;
    }
    await classe.save();
  }

  Future<void> delete(Classe classe) async => classe.delete();

  /// Recursively build Reference Code for [classe]
  String buildReferenceCode(Classe classe) {
    if (classe.parentId == -1) return '$codearq ${classe.code}';
    final parent = getEntryById(classe.parentId);
    return '${buildReferenceCode(parent)}-${classe.code}';
  }
}

extension ClasseX on Classe {
  bool get hasChildren => HiveDb.instance.hasChildren(id);
  String get referenceCode => HiveDb.instance.buildReferenceCode(this);
}
