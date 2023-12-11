import 'package:beatfusion/database/song.dart';
import 'package:hive/hive.dart';
part 'favorite.g.dart';

@HiveType(typeId: 3)
class favorite{

  @HiveField(0)
  final List<Song> song;

  favorite({
    required this.song
  });
}