import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entities/classe.dart';

extension ClasseX on Classe {
  bool get hasChildren => HiveRepository.hasChildren(id);
  List<Classe> get children => HiveRepository.getChildrenOf(id);

  String referenceCode(HiveRepository repository) {
    return repository.buildReferenceCode(this);
  }
}

class HiveRepository {
  final boxesDirectoryName = '.elpcd_database';
  final settingsBoxName = 'settings';
  final classesBoxName = 'classes';

  Future<void> initDatabase() async {
    await Hive.initFlutter(boxesDirectoryName);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter<Classe>(ClasseAdapter());
    }

    settingsBox = await Hive.openBox<Object>(settingsBoxName);
    classesBox = await Hive.openBox<Classe>(classesBoxName);
  }

  static late Box<Classe> classesBox;
  static late Box<Object> settingsBox;

  ValueListenable<Box<Classe>> listenToClasses({List<Object>? keys}) {
    return classesBox.listenable(keys: keys);
  }

  ValueListenable<Box<Object>> listenToSettings({List<Object>? keys}) {
    return settingsBox.listenable(keys: keys);
  }

  bool get isDarkMode =>
      settingsBox.get('darkMode', defaultValue: true) as bool;
  String get codearq =>
      settingsBox.get('codearq', defaultValue: 'ElPCD') as String;

  Classe? getClasseById(int id) => classesBox.get(id);

  Future<void> upsert(Classe classe) async {
    final isUpdating = classesBox.containsKey(classe.id);
    if (!isUpdating) {
      final id = await classesBox.add(classe);
      classe.id = id;
    }
    await classe.save();
  }

  static List<Classe> getChildrenOf(int? id) {
    return classesBox.values.where((child) => child.parentId == id).toList();
  }

  static bool hasChildren(int? id) {
    try {
      classesBox.values.firstWhere(
        (child) => child.parentId == id,
      );
    } on StateError {
      return false;
    }
    return true;
  }

  List<Classe> fetch({bool parentsOnly = false}) {
    if (parentsOnly) {
      return classesBox.values
          .where((clazz) => clazz.parentId == Classe.rootId)
          .toList();
    }
    return classesBox.values.toList();
  }

  Future<void> delete(Classe classe) async => classe.delete();

  /// Recursively build Reference Code for [classe]
  String buildReferenceCode(Classe classe) {
    if (classe.parentId == Classe.rootId) {
      return '$codearq ${classe.code}';
    }
    final parent = getClasseById(classe.parentId)!;

    return '${buildReferenceCode(parent)}-${classe.code}';
  }
}
