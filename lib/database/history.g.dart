// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class historyAdapter extends TypeAdapter<history> {
  @override
  final int typeId = 4;

  @override
  history read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return history(
      song: (fields[0] as List).cast<Song>(),
    );
  }

  @override
  void write(BinaryWriter writer, history obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.song);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is historyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
