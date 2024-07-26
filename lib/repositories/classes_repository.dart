import 'package:hive/hive.dart';

import '../entities/classe.dart';

class ClassesRepository {
  ClassesRepository(this._box);

  final Box<Classe> _box;

  /// Recursively build Reference Code for [classe]
  String buildReferenceCode(Classe classe) {
    if (classe.parentId == Classe.rootId) {
      return classe.code;
    }
    final parent = _box.get(classe.parentId)!;
    return '${buildReferenceCode(parent)}-${classe.code}';
  }

  Future<void> delete(Classe classe) async => classe.delete();

  Future<void> clear() => _box.clear();

  Iterable<Classe> getAllClasses() => _box.values;

  Future<void> insertAll(Map<int, Classe> classes) => _box.putAll(classes);

  Future<void> upsert(Classe classe) async {
    final isUpdating = _box.containsKey(classe.id);
    if (!isUpdating) {
      final id = await _box.add(classe);
      classe.id = id;
    }
    await classe.save();
  }

  Stream<Iterable<Classe>> watchAllClasses() {
    return _box.watch().map((_) => _box.values);
  }
}
