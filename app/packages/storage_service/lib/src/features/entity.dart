class Entity {
  final String id;
  final String name;

  const Entity({
    required this.id,
    required this.name,
  });

  factory Entity.fromMap(Map<String, Object?> map) {
    return Entity(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class EntityException implements Exception {
  const EntityException();
}

abstract class EntitiesRepository {
  Future<List<Entity>> getRoots();

  Future<List<Entity>> getChildren(String? parentId);

  Future<int> countChildren(String id, {bool recursive = false});
}
