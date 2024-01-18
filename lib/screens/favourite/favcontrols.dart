// import 'package:beatfusion/database/favorite.dart';
// import 'package:beatfusion/database/song.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// void addToFavorite() async {
//   // Assuming you have the Hive box named "song_favorite_box" already open
//   var favoriteBox = await Hive.openBox<SongFavorite>('song_favorite_box');

//   // Get the current song from the playing screen
//   Song currentSong = widget.songdata;

//   // Check if the song is not already in the favorites
//   if (!favoriteBox.values.any((favorite) => favorite.song.contains(currentSong))) {
//     // Add the current song to the favorites list
//     SongFavorite songFavorite = SongFavorite(song: [currentSong, ...?favoriteBox.get(0)?.song]);
    
//     // Save the updated favorites list to the Hive box
//     await favoriteBox.put(0, songFavorite);
    
//     // Display a message or perform any other action if needed
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Song added to favorites'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   } else {
//     // Display a message or perform any other action if the song is already in favorites
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Song is already in favorites'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
// }
