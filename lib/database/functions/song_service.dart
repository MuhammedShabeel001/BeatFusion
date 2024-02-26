import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService{
  static late Box<Song> songBox;

  static Future<void> init()async{
    await Hive.initFlutter();
    Hive.registerAdapter(SongAdapter());
    songBox = await Hive.openBox<Song>('songs');
  }
}