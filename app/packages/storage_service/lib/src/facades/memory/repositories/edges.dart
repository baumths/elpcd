import 'package:elpcd_utils/elpcd_utils.dart';

import '../../../features/edge.dart';

class InMemoryEdgesRepository extends EdgesRepository {
  late final List<Edge> edges = [];

  @override
  Future<EdgesRepositoryFailure?> add(Edge edge) {
    edges.add(edge);
    return Future.value(null);
  }

  @override
  AsyncResult<List<Edge>, EdgesRepositoryFailure> getChildren(
    String? parentId,
  ) {
    return Future.value(
      Success(edges.where((edge) => edge.parentId == parentId).toList()),
    );
  }
}
