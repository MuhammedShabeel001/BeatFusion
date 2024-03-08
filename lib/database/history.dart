
// ignore: depend_on_referenced_packages
import 'package:beatfusion/database/song.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
part 'history.g.dart';

@HiveType(typeId: 4)
class SongHistory {

  @HiveField(0)
  // ignore: non_constant_identifier_names
  List<Song> RecentSong;

  SongHistory({
    // ignore: non_constant_identifier_names
    required this.RecentSong
  });
}