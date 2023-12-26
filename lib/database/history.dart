
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
part 'history.g.dart';

@HiveType(typeId: 4)
class SongHistory {

  @HiveField(0)
  // ignore: non_constant_identifier_names
  String RecentSong;

  SongHistory({
    required this.RecentSong
  });
}