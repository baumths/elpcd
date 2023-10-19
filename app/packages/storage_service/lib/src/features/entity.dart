import 'package:elpcd_utils/elpcd_utils.dart';

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

abstract class EntitiesRepository {
  const EntitiesRepository();

  Future<EntitiesRepositoryFailure?> save(Entity entity);

  AsyncResult<Entity?, EntitiesRepositoryFailure> getById(String id);

  AsyncResult<Entity?, EntitiesRepositoryFailure> delete(String id);
}

class EntitiesRepositoryFailure {
  const EntitiesRepositoryFailure();
}
