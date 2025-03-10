class Classe implements Comparable<Classe> {
  static const rootId = -1;

  Classe({
    required this.name,
    required this.code,
    required this.parentId,
    required this.metadata,
  });

  factory Classe.root() => Classe(
        name: '',
        code: '',
        parentId: rootId,
        metadata: <String, String>{},
      );

  factory Classe.fromParent(int? parentId) => Classe(
        name: '',
        code: '',
        parentId: parentId ?? rootId,
        metadata: <String, String>{},
      );

  int? id;
  int parentId;
  String name;
  String code;
  Map<String, String> metadata;

  @override
  int compareTo(Classe other) {
    final value = code.compareTo(other.code);
    if (value == 0) return name.compareTo(other.name);
    return value;
  }

  @override
  String toString() {
    final metadadosStr = metadata.entries
        .map<String>((md) => '${md.key}: ${md.value}')
        .toList()
        .join('\n');
    return 'id ➜ { $id } '
        'parentId ➜ { $parentId } '
        'Nome ➜ { $name } '
        'Código ➜ { $code } '
        '\n⮦ Metadados\n$metadadosStr';
  }
}
