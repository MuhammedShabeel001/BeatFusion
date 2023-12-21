
import 'package:hive_flutter/hive_flutter.dart';
import 'favorite.dart';

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
 
  // @HiveField(4)
  // final String artWorkUrl;

  @HiveField(5)
  final String filePath;

  Song({
    required this.key,
    required this.name,
    required this.artist,
    required this.duration,
    // required this.artWorkUrl,
    required this.filePath
  });

  // String get artWorkUrl => null;
}