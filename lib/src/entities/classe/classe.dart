import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../repositories/hive_repository.dart';

part 'metadado.dart';
part 'classe.g.dart';

// Todo: RUN BUILD_RUNNER

@HiveType(typeId: 0)
class Classe with HiveObject {
  Classe({
    @required this.name,
    @required this.code,
    @required this.parentId,
    @required this.metadados,
    @required this.referenceCode,
  }) : children = HiveList<Classe>(HiveRepository.classesBox);

  factory Classe.root() => Classe(
        name: '',
        code: '',
        parentId: -1,
        referenceCode: '',
        metadados: <Metadado>[],
      );

  factory Classe.fromParent(int parentId) => Classe(
        name: '',
        code: '',
        parentId: parentId,
        referenceCode: '',
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
  String referenceCode;

  @HiveField(5)
  List<Metadado> metadados;

  @HiveField(6)
  HiveList<Classe> children;

  bool get hasChildren => children.isNotEmpty;

  @override
  String toString() {
    final String metadadosStr = metadados.map((m) => m.toCsv()).join('');
    return 'id ➜ { $id } '
        'parentId ➜ { $parentId } '
        'Nome ➜ { $name } '
        'Código ➜ { $code } '
        'Código de Referência ➜ { $referenceCode }'
        '\n $metadadosStr';
  }
}
