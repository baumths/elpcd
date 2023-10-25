import '../../../features/edge.dart';
import '../../../store.dart';

class InMemoryEdgesStore extends Store<Edge> {
  late final List<Edge> edges = [];

  @override
  Future<void> put(Edge object) async => edges.add(object);

  @override
  Future<Edge?> get(String key) async {
    return edges.where((edge) => edge.id == key).firstOrNull;
  }

  @override
  Stream<Edge> getWhere(bool Function(Edge object) condition) async* {
    if (edges.isEmpty) return;

    for (final edge in edges) {
      if (condition(edge)) {
        yield edge;
      }
    }
  }

  @override
  Future<Edge?> delete(String key) async {
    int? indexToRemove;

    for (final (index, edge) in edges.indexed) {
      if (edge.id == key) {
        indexToRemove = index;
        break;
      }
    }

    if (indexToRemove != null) {
      return edges.removeAt(indexToRemove);
    }

    return null;
  }
}
