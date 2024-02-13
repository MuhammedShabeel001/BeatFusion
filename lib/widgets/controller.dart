// import 'package:beatfusion/database/history.dart';
// import 'package:beatfusion/database/song.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// void historyAddSong()async{
//   // Open the SongHistory Hive box
//   var historyBox = await Hive.openBox<SongHistory>('history');

//   // Get the current song from the SongBox
//   var song = songBox.getAt(index);

//   // Get the existing list of recent songs from the SongHistory box
//   var recentSongs = historyBox.get(0)?.RecentSong ?? [];
//   int existingIndex = recentSongs.indexWhere((element) => element.key == song!.key);

//   if (existingIndex != -1) {
//     recentSongs.removeAt(existingIndex);
//   }

//   // Add the current song to the list
//   recentSongs.add(Song(
//     key: song!.key,
//     name: song.name,
//     artist: song.artist,
//     duration: song.duration,
//     filePath: song.filePath,
//   ));

//   // Update the SongHistory box with the new list
//   historyBox.put(0, SongHistory(RecentSong: recentSongs));

//   // Close the SongHistory box
//   await historyBox.close();
// }

import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addToHistory(Song song) async {
  try {
    var historyBox = await Hive.openBox<SongHistory>('history');

    // Get the existing list of recent songs from the SongHistory box
    var recentSongs = historyBox.get(0)?.RecentSong ?? [];
    int existingIndex = recentSongs.indexWhere((element) => element.key == song.key);

    if (existingIndex != -1) {
      recentSongs.removeAt(existingIndex);
    }

    // Add the current song to the list
    recentSongs.add(Song(
      key: song.key,
      name: song.name,
      artist: song.artist,
      duration: song.duration,
      filePath: song.filePath,
    ));

    // Update the SongHistory box with the new list
    historyBox.put(0, SongHistory(RecentSong: recentSongs));

    // Close the SongHistory box
    await historyBox.close();
    
    print('Song added to history successfully!');
  } catch (e) {
    print('Error adding song to history: $e');
  }
}
