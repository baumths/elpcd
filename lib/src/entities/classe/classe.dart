import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'metadado.dart';
// part 'classe.g.dart';

@HiveType(typeId: 0)
class Classe with HiveObject {
  Classe({
    @required this.name,
    @required this.code,
    this.parentId = -1,
    this.metadados = const [],
  });

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

  @override
  String toString() {
    String metadadosStr = metadados.map((m) => m.toCsv()).join('');
    return 'id ➜ { $id }'
        'parentId ➜ { $parentId }'
        'Nome ➜ { $name }'
        'Código ➜ { $code }'
        '\n $metadadosStr';
  }
}
