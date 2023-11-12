class Edge {
  final String? sourceId;
  final String targetId;

  const Edge({
    required this.sourceId,
    required this.targetId,
  });

  factory Edge.fromMap(Map<String, Object?> map) {
    return Edge(
      sourceId: map['sourceId'] as String?,
      targetId: map['targetId'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      if (sourceId != null) 'sourceId': sourceId,
      'targetId': targetId,
    };
  }
}

class EdgeException implements Exception {
  const EdgeException();
}
