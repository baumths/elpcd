import 'package:storage_service/storage_service.dart';

class Scheme {
  final int id;
  final String? name;

  const Scheme({
    required this.id,
    this.name,
  });

  factory Scheme.fromEntity(Entity entity) {
    return Scheme(id: entity.id, name: entity.name);
  }
}
