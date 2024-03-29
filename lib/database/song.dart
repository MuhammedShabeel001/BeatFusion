
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'song.g.dart';

@HiveType(typeId: 1)
class Song {
  @HiveField(0)
  final int key;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final int duration;

  @HiveField(5)
  final String filePath;

  Song({
    required this.key,
    required this.name,
    required this.artist,
    required this.duration,
    required this.filePath
  });

  static Song fromSongModel(SongModel songModel) {
    return Song(
      key: songModel.id, 
      name: songModel.title, 
      artist: songModel.artist ?? 'unknown', 
      duration: songModel.duration ?? 0, 
      filePath: songModel.data);

}
}