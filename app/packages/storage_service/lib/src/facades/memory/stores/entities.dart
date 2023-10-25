import '../../../features/entity.dart';
import '../../../store.dart';

class InMemoryEntitiesStore extends Store<Entity> {
  late final Map<String, Entity> entities = {};

  @override
  Future<void> put(Entity object) async => entities[object.id] = object;

  @override
  Future<Entity?> get(String key) async => entities[key];

  @override
  Stream<Entity> getWhere(bool Function(Entity object) condition) async* {
    if (entities.isEmpty) return;

    for (final entity in entities.values) {
      if (condition(entity)) {
        yield entity;
      }
    }
  }

  @override
  Future<Entity?> delete(String key) async => entities.remove(key);
}
