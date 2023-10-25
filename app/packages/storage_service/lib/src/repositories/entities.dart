import '../features/edge.dart';
import '../features/entity.dart';
import '../store.dart';

class EntitiesRepositoryImpl extends EntitiesRepository {
  final Store<Edge> edgesStore;
  final Store<Entity> entitiesStore;

  EntitiesRepositoryImpl({
    required this.edgesStore,
    required this.entitiesStore,
  });

  @override
  Future<List<Entity>> getRoots() => getChildren(null);

  @override
  Future<List<Entity>> getChildren(String? parentId) async {
    final edges = edgesStore.getWhere((edge) => edge.parentId == parentId);
    final entities = <Entity>[];

    await for (final Edge(childId: entityId) in edges) {
      final entity = await entitiesStore.get(entityId);

      if (entity != null) {
        entities.add(entity);
      }
    }
    return entities;
  }

  @override
  Future<int> countChildren(String id, {bool recursive = false}) async {
    return recursive ? _countDescendants(id) : _countChildren(id);
  }

  Future<int> _countChildren(String id) async {
    return edgesStore.getWhere((edge) => edge.parentId == id).length;
  }

  Future<int> _countDescendants(String id) async {
    int count = 0;

    final edges = edgesStore.getWhere((edge) => edge.parentId == id);
    await for (final edge in edges) {
      count += 1 + await _countDescendants(edge.childId);
    }

    return count;
  }
}
