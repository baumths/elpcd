import '../../features/entity.dart';
import '../../repositories/entities.dart';
import '../../storage_facade.dart';
import 'stores/edges.dart';
import 'stores/entities.dart';

class InMemoryStorageFacade extends StorageFacade {
  late InMemoryEdgesStore _edgesStore;
  late InMemoryEntitiesStore _entitiesStore;

  @override
  Future<void> init() async {
    _edgesStore = InMemoryEdgesStore();
    _entitiesStore = InMemoryEntitiesStore();
  }

  @override
  EntitiesRepository entitiesRepositoryFactory() {
    return EntitiesRepositoryImpl(
      edgesStore: _edgesStore,
      entitiesStore: _entitiesStore,
    );
  }
}
