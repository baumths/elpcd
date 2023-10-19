import '../../storage_facade.dart';
import 'repositories/edges.dart';
import 'repositories/entities.dart';

class InMemoryStorageFacade extends StorageFacade {
  @override
  InMemoryEdgesRepository edgesRepositoryFactory() {
    return InMemoryEdgesRepository();
  }

  @override
  InMemoryEntitiesRepository entitiesRepositoryFactory() {
    return InMemoryEntitiesRepository();
  }
}
