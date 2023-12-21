// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongHistoryAdapter extends TypeAdapter<SongHistory> {
  @override
  final int typeId = 4;

  @override
  SongHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongHistory(
      RecentSong: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongHistory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.RecentSong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
