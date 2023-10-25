import 'features/entity.dart';

abstract class StorageFacade {
  Future<void> init() => Future.value();
  Future<void> dispose() => Future.value();

  EntitiesRepository entitiesRepositoryFactory();
}
