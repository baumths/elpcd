import 'dart:async' show StreamController;

import '../entities/classe.dart';

abstract class ClassesRepository {
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

  Future<void> delete(Classe classe);

  Future<void> clear();

  Classe? getClassById(int id);

  Iterable<Classe> getAllClasses();

  Future<void> insertAll(Map<int, Classe> classes);

  Future<void> save(Classe classe);

  Stream<Iterable<Classe>> watchAllClasses();
}

class InMemoryClassesRepository extends ClassesRepository {
  final Map<int, Classe> memory = {};
  int _autoIncrement = 0;

  final _streamController = StreamController<List<Classe>>.broadcast();

  @override
  Future<void> clear() async {
    memory.clear();
    _streamController.add(memory.values.toList());
  }

  @override
  Future<void> delete(Classe classe) async {
    memory.remove(classe.id);
    _streamController.add(memory.values.toList());
  }

  @override
  Iterable<Classe> getAllClasses() => memory.values;

  @override
  Classe? getClassById(int id) => memory[id];

  @override
  Future<void> insertAll(Map<int, Classe> classes) async {
    memory.addAll(classes);
    _streamController.add(memory.values.toList());
  }

  @override
  Future<void> save(Classe classe) async {
    classe.id ??= _autoIncrement++;
    memory[classe.id!] = classe;
    _streamController.add(memory.values.toList());
  }

  @override
  Stream<List<Classe>> watchAllClasses() => _streamController.stream;
}
