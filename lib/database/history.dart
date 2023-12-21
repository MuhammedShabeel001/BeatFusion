import 'package:beatfusion/database/song.dart';
import 'package:hive/hive.dart';
part 'history.g.dart';

@HiveType(typeId: 4)
class SongHistory {

  @HiveField(0)
  String RecentSong;

  SongHistory({
    required this.RecentSong
  });
}