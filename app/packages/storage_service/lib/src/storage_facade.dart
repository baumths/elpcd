import 'package:uuid/uuid.dart';

import 'features/class.dart';

const _uuid = Uuid();

abstract class StorageFacade {
  static String generateUniqueIdentifier() => _uuid.v7();

  Future<void> init() => Future.value();
  Future<void> dispose() => Future.value();

  ClassesRepository get classesRepository;
}
