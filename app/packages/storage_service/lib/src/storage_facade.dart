import 'features/class.dart';

abstract class StorageFacade {
  Future<void> init() => Future.value();
  Future<void> dispose() => Future.value();

  ClassesRepository get classesRepository;
}
