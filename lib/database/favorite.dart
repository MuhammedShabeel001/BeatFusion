
import 'package:hive_flutter/hive_flutter.dart';

part 'favorite.g.dart';

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

  SongFavorite({
    required this.key,
    required this.filePath,
    required this.name,
    required this.artist
  });
}
