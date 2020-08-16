// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pcd_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PCDModelAdapter extends TypeAdapter<PCDModel> {
  @override
  final int typeId = 0;

  @override
  PCDModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PCDModel(
      legacyId: fields[0] as int,
      parentId: fields[1] as int,
      nome: fields[2] as String,
      codigo: fields[3] as String,
      subordinacao: fields[4] as String,
      registroAbertura: fields[5] as String,
      registroDesativacao: fields[6] as String,
      registroReativacao: fields[7] as String,
      registroMudancaNome: fields[8] as String,
      registroDeslocamento: fields[9] as String,
      registroExtincao: fields[10] as String,
      indicador: fields[11] as String,
      prazoCorrente: fields[12] as String,
      eventoCorrente: fields[13] as String,
      prazoIntermediaria: fields[14] as String,
      eventoIntermediaria: fields[15] as String,
      destinacaoFinal: fields[16] as String,
      registroAlteracao: fields[17] as String,
      observacoes: fields[18] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PCDModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.legacyId)
      ..writeByte(1)
      ..write(obj.parentId)
      ..writeByte(2)
      ..write(obj.nome)
      ..writeByte(3)
      ..write(obj.codigo)
      ..writeByte(4)
      ..write(obj.subordinacao)
      ..writeByte(5)
      ..write(obj.registroAbertura)
      ..writeByte(6)
      ..write(obj.registroDesativacao)
      ..writeByte(7)
      ..write(obj.registroReativacao)
      ..writeByte(8)
      ..write(obj.registroMudancaNome)
      ..writeByte(9)
      ..write(obj.registroDeslocamento)
      ..writeByte(10)
      ..write(obj.registroExtincao)
      ..writeByte(11)
      ..write(obj.indicador)
      ..writeByte(12)
      ..write(obj.prazoCorrente)
      ..writeByte(13)
      ..write(obj.eventoCorrente)
      ..writeByte(14)
      ..write(obj.prazoIntermediaria)
      ..writeByte(15)
      ..write(obj.eventoIntermediaria)
      ..writeByte(16)
      ..write(obj.destinacaoFinal)
      ..writeByte(17)
      ..write(obj.registroAlteracao)
      ..writeByte(18)
      ..write(obj.observacoes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PCDModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
