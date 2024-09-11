import 'package:hive/hive.dart';

import '../entities/classe.dart';

abstract interface class ClassesRepository {
  String buildReferenceCode(int classId);

  Future<void> delete(Classe clazz);

  Future<void> clear();

  Classe? getClassById(int id);

  Iterable<Classe> getAllClasses();

  Future<void> insertAll(Map<int, Classe> classes);

  Future<void> upsert(Classe clazz);

  Stream<Iterable<Classe>> watchAllClasses();
}

class HiveClassesRepository implements ClassesRepository {
  HiveClassesRepository(this._box);

  final Box<Classe> _box;

  @override
  String buildReferenceCode(int classId) {
    Classe? current = getClassById(classId);

    if (current == null) return '';

    final codes = <String>[];

    while (current != null) {
      codes.add(current.code.isEmpty ? '?' : current.code);
      current = getClassById(current.parentId);
    }

    return (StringBuffer()..writeAll(codes.reversed, '-')).toString();
  }

  @override
  Future<void> delete(Classe clazz) async => clazz.delete();

  @override
  Future<void> clear() async {
    await _box.clear();
    await _box.compact();
  }

  @override
  Classe? getClassById(int id) => _box.get(id);

  @override
  Iterable<Classe> getAllClasses() => _box.values;

  @override
  Future<void> insertAll(Map<int, Classe> classes) => _box.putAll(classes);

  @override
  Future<void> upsert(Classe clazz) async {
    final isUpdating = _box.containsKey(clazz.id);
    if (!isUpdating) {
      final id = await _box.add(clazz);
      clazz.id = id;
    }
    await clazz.save();
  }

  @override
  Stream<Iterable<Classe>> watchAllClasses() {
    return _box.watch().map((_) => _box.values);
  }
}
