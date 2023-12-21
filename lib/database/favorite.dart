// import 'package:beatfusion/database/song.dart';
// import 'package:hive/hive.dart';
// part 'favorite.g.dart';

// @HiveType(typeId: 3)
// class favorite{

//   @HiveField(0)
//   late String title;

//   @HiveField(1)
//   late String artist;

//   @HiveField(2)
//   late int duration;

//   favorite({
//     required this.title,
//     required this.artist,
//     required this.duration
//   });
// }

import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favorite.g.dart';

// @HiveType(typeId: 2)
// class Favourite {
//   @HiveField(0)
//   final String key;

//   Favourite({
//     required this.key,
//   });
// }

@HiveType(typeId: 2)
class SongFavorite{
  @HiveField(0)
  int key ;

  @HiveField(1)
  String filePath;

  @HiveField(2)
  String name;

  @HiveField(3)
  String artist;
  // final List<Song> favoritesong;
  

  SongFavorite({
    required this.key,
    required this.filePath,
    required this.name,
    required this.artist
  });
}
