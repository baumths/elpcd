import '../../../features/entity.dart';
import '../../../store.dart';

class InMemoryEntitiesStore extends Store<Entity> {
  late final Map<int, Entity> entities = {};

  @override
  Future<void> put(Entity object) async => entities[object.id] = object;

  @override
  Future<Entity?> get(int id) async => entities[id];

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
  Future<Entity?> delete(int id) async => entities.remove(id);
}
