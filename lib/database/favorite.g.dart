// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongFavoriteAdapter extends TypeAdapter<SongFavorite> {
  @override
  final int typeId = 2;

  @override
  SongFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongFavorite(
      key: fields[0] as int,
      filePath: fields[1] as String,
      name: fields[2] as String,
      artist: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongFavorite obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.filePath)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.artist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
