import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:hive/hive.dart';
import 'package:sqlite3/common.dart' show CommonDatabase;

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

class SqliteClassesRepository implements ClassesRepository {
  SqliteClassesRepository(this._db);

  final CommonDatabase _db;

  @override
  String buildReferenceCode(int classId) {
    final result = _db.select(
      '''
      WITH RECURSIVE path(level, code, parent) AS (
        SELECT 0, code, parent_id FROM classes WHERE id = ?
        UNION ALL
        SELECT path.level + 1, classes.code, classes.parent_id FROM classes
        JOIN path ON classes.id = path.parent
      ), path_from_root AS (
        SELECT code FROM path ORDER BY level DESC
      )
      SELECT GROUP_CONCAT(IIF(code = '', '?', code), '-')
      FROM path_from_root;
      ''',
      [classId],
    );
    return (result.rows.firstOrNull?[0] as String?) ?? '';
  }

  @override
  Future<void> clear() async {
    _db.execute('DELETE FROM classes;');
  }

  @override
  Future<void> delete(Classe clazz) async {
    _db.execute('DELETE FROM classes WHERE id = ?', [clazz.id]);
  }

  @override
  Iterable<Classe> getAllClasses() {
    final result = _db.select(
      'SELECT id, parent_id, name, code, metadata FROM classes',
    );
    return result.rows.map(
      (row) => Classe(
        parentId: row[1] as int,
        name: row[2] as String,
        code: row[3] as String,
        metadata: Map<String, String>.from(jsonDecode(row[4] as String) as Map),
      )..id = row[0] as int?,
    );
  }

  @override
  Classe? getClassById(int id) {
    final result = _db.select(
      'SELECT id, parent_id, name, code, metadata FROM classes WHERE id = ?',
      [id],
    );
    if (result.rows.firstOrNull case final row?) {
      return Classe(
        parentId: row[1] as int,
        name: row[2] as String,
        code: row[3] as String,
        metadata: Map<String, String>.from(jsonDecode(row[4] as String) as Map),
      )..id = row[0] as int?;
    }
    return null;
  }

  @override
  Future<void> insertAll(Map<int, Classe> classes) async {
    final insertStatement = _db.prepare(
      '''
      INSERT INTO classes (id, parent_id, name, code, metadata)
        VALUES (?, ?, ?, ?, ?)
      ''',
    );

    for (final entry in classes.entries) {
      insertStatement.execute([
        entry.key,
        entry.value.parentId,
        entry.value.name,
        entry.value.code,
        jsonEncode(entry.value.metadata),
      ]);
    }

    insertStatement.dispose();
  }

  @override
  Future<void> upsert(Classe clazz) async {
    final result = _db.select(
      '''
      INSERT INTO classes (id, parent_id, name, code, metadata)
        VALUES (?, ?, ?, ?, ?)
        ON CONFLICT (id) DO UPDATE SET
          parent_id = excluded.parent_id,
          name = excluded.name,
          code = excluded.code,
          metadata = excluded.metadata
      RETURNING id;
      ''',
      [
        clazz.id,
        clazz.parentId,
        clazz.name,
        clazz.code,
        jsonEncode(clazz.metadata),
      ],
    );
    if (result.rows.firstOrNull case [int id, ...]) {
      clazz.id = id;
    }
  }

  @override
  Stream<Iterable<Classe>> watchAllClasses() {
    return _db.updates
        .where((event) => event.tableName == 'classes')
        .map((_) => getAllClasses());
  }
}
