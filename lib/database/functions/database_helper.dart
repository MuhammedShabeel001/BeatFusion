// // import 'package:beatfusion/database/song.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:path_provider/path_provider.dart' as path_provider;

// // class DatabaseHelper{
// //   static Future<void> init() async {
// //     final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
// //     Hive.init(appDocumentDir.path);
// //     Hive.registerAdapter(SongAdapter());
// //   }

// //   static Future<void> openBox() async{
// //     await Hive.openBox('favourite');
// //   }

// //   static Box get favBox => Hive.box<Song>('favourite');
// // }

import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addSongToDatabase(Song song)async{
  final songBox = await Hive.openBox<Song>('songs');

  if (!songBox.containsKey(song.key)) {
    await songBox.put(song.key, song);
  }else{
  }
}