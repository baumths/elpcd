// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClasseAdapter extends TypeAdapter<Classe> {
  @override
  final int typeId = 0;

  @override
  Classe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Classe(
      name: fields[2] as String,
      code: fields[3] as String,
      parentId: fields[1] as int,
      metadados: (fields[5] as List)?.cast<Metadado>(),
      referenceCode: fields[4] as String,
    )
      ..id = fields[0] as int
      ..children = (fields[6] as HiveList)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Classe obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.parentId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.referenceCode)
      ..writeByte(5)
      ..write(obj.metadados)
      ..writeByte(6)
      ..write(obj.children);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClasseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
