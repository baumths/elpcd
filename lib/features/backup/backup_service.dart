import 'dart:convert' show jsonDecode, jsonEncode, utf8;

import 'package:file_saver/file_saver.dart';

import '../../entities/classe.dart';
import '../../repositories/classes_repository.dart';
import '../settings/settings_controller.dart';

abstract class BackupService {
  static Future<void> exportToJson({
    required ClassesRepository classesRepository,
    required SettingsController settingsController,
  }) async {
    final dump = <String, Object?>{
      'settings': {
        'codearq': settingsController.codearq,
        'darkMode': settingsController.darkMode,
      },
      'classes': <Map<String, Object?>>[
        for (final clazz in classesRepository.getAllClasses())
          <String, Object?>{
            'id': clazz.id,
            'parentId': clazz.parentId,
            'code': clazz.code,
            'name': clazz.name,
            'metadata': clazz.metadata,
          }
      ],
    };

    final json = jsonEncode(dump);

    await FileSaver.instance.saveFile(
      name: 'elpcd_backup',
      bytes: utf8.encode(json),
      ext: 'json',
      mimeType: MimeType.json,
    );
  }

  static Future<void> importFromJson({
    required String json,
    required ClassesRepository classesRepository,
    required SettingsController settingsController,
  }) async {
    final object = jsonDecode(json);
    if (object is! Map) {
      throw const BackupException('Formato Invalido');
    }

    try {
      final settings = Map<String, Object?>.from(object['settings'] as Map);

      if (settings['darkMode'] case bool darkMode?) {
        settingsController.updateDarkMode(darkMode);
      }

      if (settings['codearq'] case String codearq?) {
        settingsController.updateCodearq(codearq);
      }

      final classes = <int, Classe>{
        for (final classMap in object['classes'] as List)
          classMap['id'] as int: Classe(
            parentId: classMap['parentId'] as int,
            code: classMap['code'] as String,
            name: classMap['name'] as String,
            metadata: Map<String, String>.from(classMap['metadata'] as Map),
          )..id = classMap['id'] as int,
      };

      await classesRepository.clear();
      await classesRepository.insertAll(classes);
    } on Exception {
      throw const BackupException('Não foi possível realizar a importação');
    }
  }
}

class BackupException implements Exception {
  const BackupException(this.message);
  final String message;
}
