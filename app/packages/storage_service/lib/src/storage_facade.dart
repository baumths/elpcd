import 'features/edge.dart';
import 'features/entity.dart';
import 'collection.dart';

abstract class StorageFacade {
  Future<void> init() => Future.value();
  Future<void> dispose() => Future.value();

  Collection<Edge> get edgesCollection;
  Collection<Entity> get entitiesCollection;
}
