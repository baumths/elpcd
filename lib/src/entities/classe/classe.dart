import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../repositories/hive_repository.dart';

part 'metadado.dart';
// part 'classe.g.dart';

// Todo: RUN BUILD_RUNNER

@HiveType(typeId: 0)
class Classe with HiveObject {
  Classe({
    @required this.name,
    @required this.code,
    @required this.parentId,
    @required this.metadados,
  }) : children = HiveList<Classe>(HiveRepository.classesBox);

  factory Classe.root() => Classe(
        name: '',
        code: '',
        parentId: -1,
        metadados: <Metadado>[],
      );

  @HiveField(0)
  int id;

  @HiveField(1)
  int parentId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String code;

  @HiveField(4)
  List<Metadado> metadados;

  @HiveField(5)
  HiveList<Classe> children;

  @override
  String toString() {
    final String metadadosStr = metadados.map((m) => m.toCsv()).join('');
    return 'id ➜ { $id } '
        'parentId ➜ { $parentId } '
        'Nome ➜ { $name } '
        'Código ➜ { $code }'
        '\n $metadadosStr';
  }
}
