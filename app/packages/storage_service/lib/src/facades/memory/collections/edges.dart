import '../../../features/edge.dart';
import '../../../collection.dart';

class InMemoryEdgesCollection extends Collection<Edge> {
  late final Map<int, Edge> edges = {};

  @override
  Future<void> put(Edge object) async => edges[object.id] = object;

  @override
  Future<Edge?> get(int id) async => edges[id];

  @override
  Stream<Edge> getWhere(bool Function(Edge object) condition) async* {
    if (edges.isEmpty) return;

    for (final edge in edges.values) {
      if (condition(edge)) {
        yield edge;
      }
    }
  }

  @override
  Future<Edge?> delete(int id) async => edges.remove(id);
}
