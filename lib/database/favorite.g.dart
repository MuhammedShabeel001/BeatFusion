// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class favoriteAdapter extends TypeAdapter<favorite> {
  @override
  final int typeId = 3;

  @override
  favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return favorite(
      song: (fields[0] as List).cast<Song>(),
    );
  }

  @override
  void write(BinaryWriter writer, favorite obj) {
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
      other is favoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}