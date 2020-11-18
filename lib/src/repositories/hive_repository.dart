import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../entities/entities.dart';

extension ClasseX on Classe {
  bool get hasChildren => children.isNotEmpty;
  void addChild(Classe child) => children.add(child);
  String get referenceCode => HiveRepository.instance.buildReferenceCode(this);
}

class HiveRepository {
  final boxesDirectoryName = '.elpcd_database';
  final settingsBoxName = 'settings';
  final classesBoxName = 'classes';

  // Singleton
  HiveRepository._privateConstructor();
  static HiveRepository instance = HiveRepository._privateConstructor();

  Future<void> initDatabase() async {
    await Hive.initFlutter(boxesDirectoryName);

    // Hive.registerAdapter<Classe>(ClasseAdapter());

    settingsBox = await Hive.openBox<dynamic>(settingsBoxName);
    classesBox = await Hive.openBox<Classe>(classesBoxName);
  }

  static Box<Classe> classesBox;
  static Box<dynamic> settingsBox;

  bool get isDarkMode =>
      settingsBox.get('darkMode', defaultValue: true) as bool;
  String get codearq =>
      settingsBox.get('codearq', defaultValue: 'ElPCD') as String;

  List<Classe> getAllClasses() => classesBox.values.toList();

  Classe getClasseById(int id) => classesBox.get(id);

  Future<void> insert(Classe classe) async {
    final bool isNewClasse = !classesBox.containsKey(classe.id);
    if (isNewClasse) {
      final int id = await classesBox.add(classe);
      classe.id = id;
    }
    await classe.save();
    if (classe.parentId != -1) {
      addChildToParentsChildren(classe);
    }
  }

  void addChildToParentsChildren(Classe child) {
    final parent = getClasseById(child.parentId);
    parent.addChild(child);
  }

  Future<void> delete(Classe classe) async => classe.delete();

  /// Recursively build Reference Code for [classe]
  String buildReferenceCode(Classe classe) {
    if (classe.parentId == -1) return '$codearq ${classe.code}';
    final parent = getClasseById(classe.parentId);
    return '${buildReferenceCode(parent)}-${classe.code}';
  }
}
