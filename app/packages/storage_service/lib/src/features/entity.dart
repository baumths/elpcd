class Entity {
  final String id;
  final String name;

  const Entity({
    required this.id,
    required this.name,
  });

  Entity.create({String name = ''}) : this(id: '', name: name);

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
