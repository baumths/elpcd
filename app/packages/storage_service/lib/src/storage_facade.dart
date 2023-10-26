import 'repositories/entities.dart';

abstract class StorageFacade {
  Future<void> init() => Future.value();
  Future<void> dispose() => Future.value();

  EntitiesRepository entitiesRepositoryFactory();
}
