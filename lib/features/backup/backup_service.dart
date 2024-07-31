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
      'settings': {
        'institutionCode': settingsController.institutionCode,
        'darkMode': settingsController.darkMode,
      },
      'classes': <Map<String, Object?>>[
        for (final clazz in classesRepository.getAllClasses())
          if (clazz.id != null)
            <String, Object?>{
              'id': clazz.id,
              'parentId': clazz.parentId,
              'code': clazz.code,
              'name': clazz.name,
              'metadata': clazz.metadata,
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

    if (object['classes'] case final List<Object?> classesMaps?) {
      final classesById = <int, Classe>{
        for (final classMap in classesMaps)
          if (_classFromJson(classMap) case final Classe classe)
            classe.id!: classe,
      };

      await classesRepository.clear();
      await classesRepository.insertAll(classesById);
    } else {
      throw const BackupException();
    }

    if (object['settings'] case final Map<Object?, Object?> settings?) {
      if (settings['darkMode'] case bool darkMode?) {
        settingsController.updateDarkMode(darkMode);
      }

      if (settings['institutionCode'] case String institutionCode?) {
        settingsController.updateInstitutionCode(institutionCode);
      }
    }
  }

  static Classe _classFromJson(Object? value) {
    if (value
        case {
          'id': int(),
          'parentId': int(),
          'name': String(),
          'code': String(),
        }) {
      return Classe(
        parentId: value['parentId'] as int,
        name: value['name'] as String,
        code: value['code'] as String,
        metadata: _metadataFromJson(value['metadata']),
      )..id = value['id'] as int;
    }
    throw const BackupException();
  }

  static Map<String, String> _metadataFromJson(Object? value) {
    if (value is Map?) {
      if (value == null) {
        return <String, String>{};
      }
      try {
        return Map<String, String>.from(value);
      } on TypeError {
        throw const BackupException();
      }
    }
    throw const BackupException();
  }
}

class BackupException implements Exception {
  const BackupException();
}
