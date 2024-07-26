import 'package:hive_flutter/hive_flutter.dart';

import '../entities/classe.dart';

class HiveRepository {
  final boxesDirectoryName = '.elpcd_database';
  final classesBoxName = 'classes';

  Future<void> initDatabase() async {
    await Hive.initFlutter(boxesDirectoryName);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter<Classe>(ClasseAdapter());
    }

    classesBox = await Hive.openBox<Classe>(classesBoxName);
  }

  static late Box<Classe> classesBox;

  Future<void> upsert(Classe classe) async {
    final isUpdating = classesBox.containsKey(classe.id);
    if (!isUpdating) {
      final id = await classesBox.add(classe);
      classe.id = id;
    }
    await classe.save();
  }

  Future<void> delete(Classe classe) async => classe.delete();

  /// Recursively build Reference Code for [classe]
  String buildReferenceCode(Classe classe) {
    if (classe.parentId == Classe.rootId) {
      return classe.code;
    }
    final parent = classesBox.get(classe.parentId)!;
    return '${buildReferenceCode(parent)}-${classe.code}';
  }

  Iterable<Classe> getAllClasses() => classesBox.values;

  Stream<Iterable<Classe>> watchAllClasses() {
    return classesBox.watch().map((_) => classesBox.values);
  }
}
