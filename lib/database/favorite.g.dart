// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongFavoriteAdapter extends TypeAdapter<SongFavorite> {
  @override
  final int typeId = 3;

  @override
  SongFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongFavorite(
      song: (fields[0] as List).cast<Song>(),
    );
  }

  @override
  void write(BinaryWriter writer, SongFavorite obj) {
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
      other is SongFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
