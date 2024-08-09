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

  int? _editingClassId;

  int get parentId => _parentId;
  int _parentId;

  late Map<String, String> _metadata = {};

  void init({int? editingClassId}) {
    if (editingClassId != null) {
      edit(editingClassId);
    }
  }

  void edit(int classId) {
    if (_repository.getClassById(classId) case final Classe clazz?) {
      _editingClassId = classId;
      _parentId = clazz.parentId;
      _metadata = <String, String>{
        ...clazz.metadata,
        EarqBrasilMetadata.nome.key: clazz.name,
        EarqBrasilMetadata.codigo.key: clazz.code,
      };
      updateSubordination(parentId);
    }
  }

  String? valueOf(EarqBrasilMetadata metadata) => _metadata[metadata.key];

  void updateValueOf(EarqBrasilMetadata metadata, String value) {
    _metadata[metadata.key] = value;
  }

  void save() {
    Classe? clazz;

    if (_editingClassId != null) {
      clazz = _repository.getClassById(_editingClassId!);
    }

    clazz ??= Classe.fromParent(parentId);
    updateClassMetadata(clazz);

    _repository.upsert(clazz);
  }

  @visibleForTesting
  void updateClassMetadata(Classe clazz) {
    // Only used to display class hierarchy, should not be persisted.
    _metadata.remove(EarqBrasilMetadata.subordinacao.key);

    clazz.name = _metadata.remove(EarqBrasilMetadata.nome.key)?.trim() ?? '';
    clazz.code = _metadata.remove(EarqBrasilMetadata.codigo.key)?.trim() ?? '';

    for (final metadata in EarqBrasilMetadata.values) {
      final value = _metadata.remove(metadata.key)?.trim();

      if (value == null || value.isEmpty) {
        clazz.metadata.remove(metadata.key);
      } else {
        clazz.metadata[metadata.key] = value;
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
