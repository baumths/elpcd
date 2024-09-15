import 'dart:convert' show jsonDecode, jsonEncode;

import '../../entities/classe.dart';
import '../../repositories/classes_repository.dart';
import '../settings/settings_controller.dart';

abstract class BackupService {
  static String exportToJson({
    required ClassesRepository classesRepository,
    required SettingsController settingsController,
  }) {
    return jsonEncode({
      if (settingsController.institutionCode != defaultInstitutionCode)
        'institutionCode': settingsController.institutionCode,
      'classes': <Map<String, Object?>>[
        for (final clazz in classesRepository.getAllClasses())
          if (clazz.id != null)
            <String, Object?>{
              'id': clazz.id,
              if (clazz.parentId != Classe.rootId) 'parentId': clazz.parentId,
              'code': clazz.code,
              'name': clazz.name,
              if (clazz.metadata.isNotEmpty) 'metadata': clazz.metadata,
            }
      ],
    });
  }

  static Future<void> importFromJson({
    required String json,
    required ClassesRepository classesRepository,
    required SettingsController settingsController,
  }) async {
    final object = jsonDecode(json);
    if (object is! Map) {
      throw const BackupException();
    }

    if (object['classes'] case final List<Object?> maps?) {
      try {
        final classesById = <int, Classe>{};

        for (final Object? map in maps) {
          final clazz = _classFromMap(map as Map);
          classesById[clazz.id!] = clazz;
        }

        await classesRepository.clear();
        await classesRepository.insertAll(classesById);
      } on TypeError {
        throw const BackupException();
      }
    } else {
      throw const BackupException();
    }

    if (object['institutionCode'] case String institutionCode?) {
      settingsController.updateInstitutionCode(institutionCode);
    }
  }

  static Classe _classFromMap(Map<Object?, Object?> map) {
    return Classe(
      parentId: map['parentId'] as int? ?? Classe.rootId,
      code: map['code'] as String? ?? '',
      name: map['name'] as String? ?? '',
      metadata: Map<String, String>.from(map['metadata'] as Map? ?? {}),
    )..id = map['id'] as int;
  }
}

class BackupException implements Exception {
  const BackupException();
}
