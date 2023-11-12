import 'dart:async' show StreamController;

import '../../features/class.dart';
import '../../features/edge.dart';
import '../../features/entity.dart';

class VirtualClassesRepository implements ClassesRepository {
  late final virtualEntities = <String, Entity>{};
  late var virtualEdges = <Edge>[];

  late final controller = StreamController<Class>.broadcast();

  @override
  Future<Class?> getById(String id) async {
    final entity = virtualEntities[id];
    if (entity == null) return null;

    String? parentId;
    try {
      final edge = virtualEdges.firstWhere((e) => e.targetId == id);
      parentId = edge.sourceId;
    } on StateError {
      parentId = null;
    }

    return Class(
      id: entity.id,
      parentId: parentId,
      name: entity.name,
    );
  }

  @override
  Future<List<Class>> getChildren(String? id) async {
    final edges = virtualEdges.where((e) => e.sourceId == id);
    final classes = await Future.wait(
      edges.map((r) => getById(r.targetId.toString())),
    );
    return List.from(classes.where((c) => c != null));
  }

  @override
  Future<void> save(Class clazz) async {
    virtualEntities[clazz.id] = Entity(id: clazz.id, name: clazz.name);

    virtualEdges = <Edge>[
      for (final edge in virtualEdges)
        if (edge.targetId == clazz.id)
          Edge(
            sourceId: clazz.parentId,
            targetId: clazz.id,
          )
        else
          edge
    ];

    controller.add(clazz);
  }

  @override
  Future<Class?> delete(String id) async {
    final entity = virtualEntities.remove(id);
    final edgeIndex = virtualEdges.indexWhere((e) => e.targetId == id);
    final edge = virtualEdges.removeAt(edgeIndex);

    if (entity != null) {
      final clazz = Class(
        id: entity.id,
        parentId: edge.sourceId,
        name: entity.name,
      );
      controller.add(clazz);
    }
    return null;
  }

  @override
  Stream<Class> watch() => controller.stream;

  @override
  Future<int> countChildren(String id, {bool recursive = false}) async {
    return recursive ? _countDescendants(id) : _countChildren(id);
  }

  Future<int> _countChildren(String id) async {
    return virtualEdges.where((edge) => edge.sourceId == id).length;
  }

  Future<int> _countDescendants(String id) async {
    int count = 0;

    final children = virtualEdges.where((edge) => edge.sourceId == id);
    for (final Edge(targetId: id) in children) {
      count += 1 + await _countDescendants(id);
    }

    return count;
  }
}
