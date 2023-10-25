class Edge {
  final String childId;
  final String? parentId;

  const Edge({
    required this.childId,
    required this.parentId,
  });

  factory Edge.fromMap(Map<String, Object?> map) {
    return Edge(
      childId: map['childId'] as String,
      parentId: map['parentId'] as String?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'childId': childId,
      if (parentId != null) 'parentId': parentId,
    };
  }
}

class EdgeException implements Exception {
  const EdgeException();
}
