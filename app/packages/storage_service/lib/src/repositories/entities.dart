import '../features/edge.dart';
import '../features/entity.dart';
import '../store.dart';

class EntitiesRepository {
  final Store<Edge> edgesStore;
  final Store<Entity> entitiesStore;

  EntitiesRepository({
    required this.edgesStore,
    required this.entitiesStore,
  });

  Future<List<Entity>> getRoots() => getChildren(null);

  Future<List<Entity>> getChildren(int? parentId) async {
    final edges = edgesStore.getWhere((edge) => edge.fromId == parentId);
    final entities = <Entity>[];

    await for (final Edge(toId: id) in edges) {
      final entity = await entitiesStore.get(id);

      if (entity != null) {
        entities.add(entity);
      }
    }
    return entities;
  }

  Future<int> countChildren(int id, {bool recursive = false}) async {
    return recursive ? _countDescendants(id) : _countChildren(id);
  }

  Future<int> _countChildren(int id) async {
    return edgesStore.getWhere((edge) => edge.fromId == id).length;
  }

  Future<int> _countDescendants(int id) async {
    int count = 0;

    final edges = edgesStore.getWhere((edge) => edge.fromId == id);
    await for (final Edge(toId: id) in edges) {
      count += 1 + await _countDescendants(id);
    }

    return count;
  }
}
