import 'package:elpcd_utils/elpcd_utils.dart';

import '../../../features/entity.dart';

class InMemoryEntitiesRepository extends EntitiesRepository {
  late final Map<String, Entity> entities = {};

  @override
  AsyncResult<Entity?, EntitiesRepositoryFailure> getById(String id) {
    return Future.value(Success(entities[id]));
  }

  @override
  Future<EntitiesRepositoryFailure?> save(Entity entity) {
    entities[entity.id] = entity;
    return Future.value(null);
  }

  @override
  AsyncResult<Entity?, EntitiesRepositoryFailure> delete(String id) {
    return Future.value(Success(entities.remove(id)));
  }
}
