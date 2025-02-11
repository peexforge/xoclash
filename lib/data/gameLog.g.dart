// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameLog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GamelogAdapter extends TypeAdapter<Gamelog> {
  @override
  final int typeId = 1;

  @override
  Gamelog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gamelog(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Gamelog obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gameType)
      ..writeByte(1)
      ..write(obj.result)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamelogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
