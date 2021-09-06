import 'package:hive/hive.dart';

import '../../repositories/hive_repository.dart';

part 'classe.g.dart';

@HiveType(typeId: 0)
class Classe extends HiveObject {
  Classe({
    required this.name,
    required this.code,
    required this.parentId,
    required this.metadata,
  });

  factory Classe.root() => Classe(
        name: '',
        code: '',
        parentId: HiveRepository.kRootId,
        metadata: <String, String>{},
      );

  factory Classe.fromParent(int? parentId) => Classe(
        name: '',
        code: '',
        parentId: parentId ?? HiveRepository.kRootId,
        metadata: <String, String>{},
      );

  @HiveField(0)
  int? id;

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
