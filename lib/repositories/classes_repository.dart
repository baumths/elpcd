import 'package:hive/hive.dart';

import '../entities/classe.dart';

class ClassesRepository {
  ClassesRepository(this._box);

  final Box<Classe> _box;

  String buildReferenceCode(int classId) {
    Classe? current = getClassById(classId);

    if (current == null) return '';

    final codes = <String>[];

    while (current != null) {
      codes.add(current.code);
      current = getClassById(current.parentId);
    }

    return (StringBuffer()..writeAll(codes.reversed, '-')).toString();
  }

  Future<void> delete(Classe classe) async => classe.delete();

  Future<void> clear() async {
    await _box.clear();
    await _box.compact();
  }

  Classe? getClassById(int id) => _box.get(id);

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
