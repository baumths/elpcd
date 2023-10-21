import '../../../features/entity.dart';

class InMemoryEntitiesRepository extends EntitiesRepository {
  late final Map<String, Entity> entities = {};

  @override
  Future<(Entity?, EntitiesRepositoryFailure?)> getById(String id) {
    return Future.value((entities[id], null));
  }

  @override
  Future<EntitiesRepositoryFailure?> save(Entity entity) {
    entities[entity.id] = entity;
    return Future.value(null);
  }

  @override
  Future<(Entity?, EntitiesRepositoryFailure?)> delete(String id) {
    return Future.value((entities.remove(id), null));
  }
}
