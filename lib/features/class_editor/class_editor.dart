import 'package:flutter/foundation.dart' show visibleForTesting;

import '../../entities/classe.dart';
import '../../repositories/classes_repository.dart';
import 'earq_brasil_metadata.dart';

class ClassEditor {
  ClassEditor({
    required ClassesRepository repository,
    int? parentId,
  })  : _parentId = parentId ?? Classe.rootId,
        _repository = repository;

  final ClassesRepository _repository;

  int? get editingClassId => _editingClassId;
  int? _editingClassId;

  int get parentId => _parentId;
  int _parentId;

  @visibleForTesting
  late Map<String, String> metadata = {};

  void init({int? editingClassId}) {
    if (editingClassId != null) {
      edit(editingClassId);
    }
  }

  void edit(int classId) {
    if (_repository.getClassById(classId) case final Classe clazz?) {
      _editingClassId = classId;
      _parentId = clazz.parentId;
      metadata = <String, String>{
        ...clazz.metadata,
        EarqBrasilMetadata.nome.key: clazz.name,
        EarqBrasilMetadata.codigo.key: clazz.code,
      };
      updateSubordination(parentId);
    }
  }

  String? valueOf(EarqBrasilMetadata entry) => metadata[entry.key];

  void updateValueOf(EarqBrasilMetadata entry, String value) {
    metadata[entry.key] = value;
  }

  Classe save() {
    Classe? clazz;

    if (_editingClassId != null) {
      clazz = _repository.getClassById(_editingClassId!);
    }

    clazz ??= Classe.fromParent(parentId);
    applyMetadata(clazz);

    _repository.upsert(clazz);
    return clazz;
  }

  @visibleForTesting
  void applyMetadata(Classe clazz) {
    // Only used to display class hierarchy, should not be persisted.
    metadata.remove(EarqBrasilMetadata.subordinacao.key);

    clazz.name = metadata.remove(EarqBrasilMetadata.nome.key)?.trim() ?? '';
    clazz.code = metadata.remove(EarqBrasilMetadata.codigo.key)?.trim() ?? '';

    for (final entry in EarqBrasilMetadata.values) {
      final value = metadata.remove(entry.key)?.trim();

      if (value == null || value.isEmpty) {
        clazz.metadata.remove(entry.key);
      } else {
        clazz.metadata[entry.key] = value;
      }
    }
  }

  @visibleForTesting
  void updateSubordination(int parentId) {
    updateValueOf(
      EarqBrasilMetadata.subordinacao,
      _repository.buildReferenceCode(parentId),
    );
  }
}
