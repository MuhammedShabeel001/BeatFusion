import 'package:beatfusion/database/song.dart';
import 'package:hive/hive.dart';
part 'history.g.dart';

@HiveType(typeId: 4)
class history {

  @HiveField(0)
  final List<Song> song;

  history({
    required this.song
  });
}