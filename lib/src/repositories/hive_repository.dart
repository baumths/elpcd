import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../entities/entities.dart';

extension ClasseX on Classe {
  bool get hasChildren => HiveRepository.hasChildren(id);
  List<Classe> get children => HiveRepository.getChildrenOf(id);
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

    settingsBox = await Hive.openBox<dynamic>(settingsBoxName);
    classesBox = await Hive.openBox<Classe>(classesBoxName);
  }

  static Box<Classe> classesBox;
  static Box<dynamic> settingsBox;

  ValueListenable<Box<dynamic>> listenToClasses({List<dynamic> keys}) {
    return classesBox.listenable(keys: keys);
  }

  ValueListenable<Box<dynamic>> listenToSettings({List<dynamic> keys}) {
    return settingsBox.listenable(keys: keys);
  }

  bool get isDarkMode =>
      settingsBox.get('darkMode', defaultValue: true) as bool;
  String get codearq =>
      settingsBox.get('codearq', defaultValue: 'ElPCD') as String;

  Classe getClasseById(int id) => classesBox.get(id);

  Future<void> insert(Classe classe) async {
    final int id = await classesBox.add(classe);
    classe.id = id;
    await classe.save();

    if (classe.parentId != -1) {
      addChildToParentsChildren(classe);
    }
  }

  static List<Classe> getChildrenOf(int id) {
    return classesBox.values.where((c) => c.parentId == id).toList();
  }

  static bool hasChildren(int id) {
    final child = classesBox.values.firstWhere(
      (c) => c.parentId == id,
      orElse: () => null,
    );
    // ignore: avoid_bool_literals_in_conditional_expressions
    return child == null ? false : true;
  }

  List<Classe> fetch({bool parents = false}) {
    if (parents) {
      return classesBox.values.where((p) => p.parentId == -1).toList();
    }
    return classesBox.values.toList();
  }

  Future<void> update(Classe classe) async {
    if (getClasseById(classe.id) == null) return insert(classe);
    return classe.save();
  }

  Future<void> delete(Classe classe) async => classe.delete();

  void addChildToParentsChildren(Classe child) {
    final parent = getClasseById(child.parentId);
    parent.children.add(child);
  }

  /// Recursively build Reference Code for [classe]
  String buildReferenceCode(Classe classe) {
    if (classe.parentId == -1) return '$codearq ${classe.code}';
    final parent = getClasseById(classe.parentId);
    return '${buildReferenceCode(parent)}-${classe.code}';
  }
}
