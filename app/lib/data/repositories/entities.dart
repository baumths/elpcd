import 'package:storage_service/storage_service.dart';

class EntitiesRepository {
  final Collection<Edge> edgesCollection;
  final Collection<Entity> entitiesCollection;

  EntitiesRepository({
    required this.edgesCollection,
    required this.entitiesCollection,
  });

  Future<List<Entity>> getRoots() => getChildren(null);

  Future<List<Entity>> getChildren(int? parentId) async {
    final edges = edgesCollection.getWhere((edge) => edge.fromId == parentId);
    final entities = <Entity>[];

    await for (final Edge(toId: id) in edges) {
      final entity = await entitiesCollection.get(id);

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
    return edgesCollection.getWhere((edge) => edge.fromId == id).length;
  }

  Future<int> _countDescendants(int id) async {
    int count = 0;

    final edges = edgesCollection.getWhere((edge) => edge.fromId == id);
    await for (final Edge(toId: id) in edges) {
      count += 1 + await _countDescendants(id);
    }

    return count;
  }
}