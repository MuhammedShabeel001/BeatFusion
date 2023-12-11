
import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'song.dart';
part 'playlist.g.dart';

@HiveType(typeId: 2)
class Playlist {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<Song> song;

  Playlist({
    required this.name,
    required this.song
  });
}