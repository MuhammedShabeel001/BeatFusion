// import 'package:beatfusion/database/song.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';

// ValueNotifier<List<SongModel>> SongNotifier = ValueNotifier([]);

// Future<void> addSongs(SongModel value)async{
//   final songDB = await Hive.openBox<SongModel>('song_db');
//   await songDB.add(value);
//   SongNotifier.value.add(value);

//   SongNotifier.notifyListeners();

// }

// Future<void> getAllSongs()async{
//   final songDB = await Hive.openBox<SongModel>('song_db');
//   SongNotifier.value.clear();

//   SongNotifier.value.addAll(songDB.values);
//   SongNotifier.notifyListeners();
// }