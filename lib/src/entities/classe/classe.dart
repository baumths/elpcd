import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'classe.g.dart';

// Todo: RUN BUILD_RUNNER

@HiveType(typeId: 0)
class Classe with HiveObject {
  Classe({
    @required this.name,
    @required this.code,
    @required this.parentId,
    @required this.metadata,
  });

  factory Classe.root() => Classe(
        name: '',
        code: '',
        parentId: -1,
        metadata: <String, String>{},
      );

  factory Classe.fromParent(int parentId) => Classe(
        name: '',
        code: '',
        parentId: parentId,
        metadata: <String, String>{},
      );

  @HiveField(0)
  int id;

  @HiveField(1)
  int parentId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String code;

  @HiveField(5)
  Map<String, String> metadata;

  @override
  String toString() {
    final String metadadosStr = metadata.entries
        .map<String>((md) => '${md.key}: ${md.value}')
        .toList()
        .join('\n');
    return 'id ➜ { $id } '
        'parentId ➜ { $parentId } '
        'Nome ➜ { $name } '
        'Código ➜ { $code } '
        '\n⮦ MetadataType\n$metadadosStr';
  }
}
