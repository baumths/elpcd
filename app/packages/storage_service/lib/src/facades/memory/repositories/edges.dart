import '../../../features/edge.dart';

class InMemoryEdgesRepository extends EdgesRepository {
  late final List<Edge> edges = [];

  @override
  Future<EdgesRepositoryFailure?> add(Edge edge) {
    edges.add(edge);
    return Future.value(null);
  }

  @override
  Future<(List<Edge>?, EdgesRepositoryFailure?)> getChildren(
    String? parentId,
  ) {
    return Future.value(
      (edges.where((edge) => edge.parentId == parentId).toList(), null),
    );
  }
}
