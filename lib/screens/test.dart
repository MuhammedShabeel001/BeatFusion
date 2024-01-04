// // // import 'package:flutter/material.dart';

// // // import 'package:hive_flutter/adapters.dart';
// // // import 'package:vibesync/database/boxx.dart';
// // // import 'package:vibesync/database/model/model.dart';

// // // import 'package:vibesync/splash.dart';

// // // Future<void> main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Hive.initFlutter();
// // //   Hive.registerAdapter(songplaylistAdapter());
// // //   Hive.registerAdapter(videoplaylistAdapter());
// // //   Hive.registerAdapter(songshiveAdapter());
// // //   Hive.registerAdapter(videohiveAdapter());
// // //   Hive.registerAdapter(SongfavoriteAdapter());
// // //   Hive.registerAdapter(VideofavoriteAdapter());
// // //   await openBoxes(); // Function to open boxes
// // //   runApp(const VibeSync());
// // // }

// // // Future<void> openBoxes() async {

// // //   boxsongplaylist = await Hive.openBox<songplaylist>('songplaylistBox');
// // //   boxvideoplaylist = await Hive.openBox<videoplaylist>('videoplaylistBox');
// // //   boxsongs = await Hive.openBox<songshive>('songshiveBox');
// // //   boxvideo = await Hive.openBox<videohive>('videosBox');
// // //   boxfavoritesongs =await Hive.openBox<Songfavorite>('favoritesongs');
// // //   boxfavoritevideos = await Hive.openBox<Videofavorite>('favoritevideos');
// // // }

// // // class VibeSync extends StatelessWidget {
// // //   const VibeSync({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return const MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: Screensplash(),
// // //     );
// // //   }
// // // }



// // import 'package:flutter/material.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:hive/hive.dart';
// // import 'package:your_project/models/playlist.dart'; // Update with the correct import path

// // class PlaylistScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Playlist Screen'),
// //       ),
// //       body: Center(
// //         child: Text('Your playlist content goes here'),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           _showAddPlaylistDialog(context);
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }

// //   Future<void> _showAddPlaylistDialog(BuildContext context) async {
// //     TextEditingController playlistNameController = TextEditingController();

// //     return showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Add Playlist'),
// //           content: TextField(
// //             controller: playlistNameController,
// //             decoration: InputDecoration(hintText: 'Enter playlist name'),
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text('Cancel'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //             TextButton(
// //               child: Text('Add'),
// //               onPressed: () {
// //                 // Get the entered playlist name
// //                 String playlistName = playlistNameController.text.trim();

// //                 // Create a new playlist object
// //                 Playlist newPlaylist = Playlist(name: playlistName, song: []);

// //                 // Store the playlist in Hive
// //                 var playlistBox = Hive.box<Playlist>('playlists');
// //                 playlistBox.add(newPlaylist);

// //                 // Close the dialog
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
// // ... (your imports)

// class _SongPlayListViewState extends State<SongPlayListView> {
//   // ... (your properties)

//   Set<int> selectedSongs = Set<int>();

//   @override
//   Widget build(BuildContext context) {
//     final songBox = Hive.box<Song>('songsbox');
//     print(songBox.length);

//     return ListView.builder(
//       itemCount: songBox.length,
//       itemBuilder: (context, index) {
//         final song = songBox.getAt(index);

//         return ListTile(
//           contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           title: SizedBox(
//             height: 18,
//             child: Text(
//               song!.name,
//               style: FontStyles.name,
//               maxLines: 1,
//             ),
//           ),
//           subtitle: Text(
//             song.artist,
//             style: FontStyles.artist,
//             maxLines: 1,
//           ),
//           leading: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(9),
//               color: MyTheme().primaryColor,
//             ),
//             child: const Icon(
//               Icons.music_note_rounded,
//               color: Colors.white,
//             ),
//           ),
//           trailing: IconButton(
//             onPressed: () {
//               setState(() {
//                 if (selectedSongs.contains(index)) {
//                   selectedSongs.remove(index);
//                 } else {
//                   selectedSongs.add(index);
//                 }
//               });
//             },
//             icon: Icon(
//               selectedSongs.contains(index) ? Icons.check_box : Icons.add,
//               color: MyTheme().iconColor,
//             ),
//           ),
//           onTap: () async {
//             // Handle tap actions here
//             _updateSongDetails(index);
//             _changePlayerVisibility();
//           },
//         );
//       },
//     );
//   }
// }
