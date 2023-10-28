import '../../features/edge.dart';
import '../../features/entity.dart';
import '../../storage_facade.dart';
import '../../collection.dart';
import 'collections/edges.dart';
import 'collections/entities.dart';

class InMemoryStorageFacade extends StorageFacade {
  InMemoryEdgesCollection? _edgesCollection;
  InMemoryEntitiesCollection? _entitiesCollection;

  @override
  Future<void> init() async {
    _edgesCollection = InMemoryEdgesCollection();
    _entitiesCollection = InMemoryEntitiesCollection();
  }

  @override
  Future<void> dispose() async {
    _edgesCollection = null;
    _entitiesCollection = null;
  }

  @override
  Collection<Edge> get edgesCollection {
    assert(_debugCheckCollectionNotNull(_edgesCollection));
    return _edgesCollection!;
  }

  @override
  Collection<Entity> get entitiesCollection {
    assert(_debugCheckCollectionNotNull(_entitiesCollection));
    return _entitiesCollection!;
  }

  bool _debugCheckCollectionNotNull(Collection<dynamic>? collection) {
    assert(
      collection != null,
      '${collection.runtimeType} is null. '
      'Did you forget to call StorageFacade.init()?',
    );
    return collection != null;
  }
}
