
// import 'package:beatfusion/database/song.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// part 'favorite.g.dart';

// @HiveType(typeId: 2)
// class SongFavorite{
//   @HiveField(0)
//   final List<Song> song;

  

//   SongFavorite({
//     required this.song,
    
//   });
// }


import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favorite.g.dart';

@HiveType(typeId: 2)
class SongFavorite {
  @HiveField(0)
  final List<Song> song;

  SongFavorite({required this.song});

  
}