class Edge {
  final int id;
  final int toId;
  final int? fromId;

  const Edge({
    required this.id,
    required this.toId,
    required this.fromId,
  });

  factory Edge.fromMap(Map<String, Object?> map) {
    return Edge(
      id: map['id'] as int,
      toId: map['toId'] as int,
      fromId: map['fromId'] as int?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'toId': toId,
      if (fromId != null) 'fromId': fromId,
    };
  }
}

class EdgeException implements Exception {
  const EdgeException();
}
