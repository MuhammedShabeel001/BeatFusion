// // import 'package:beatfusion/common/text_style.dart';
// // import 'package:beatfusion/common/theme.dart';
// // import 'package:beatfusion/database/favorite.dart';
// // import 'package:beatfusion/screens/playing.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:just_audio/just_audio.dart';
// // import 'package:on_audio_query/on_audio_query.dart';

// // class FavListView extends StatefulWidget {
// //   final List<SongModel> favs;

// //   FavListView({required this.favs}); 

// //   @override
// //   State<FavListView> createState() => _FavListViewState();
// // }

// // class _FavListViewState extends State<FavListView> {

// //   final AudioPlayer player = AudioPlayer();
  
// //   @override
// //   Widget build(BuildContext context) {
// //     final favBox = Hive.box<favorite>('fav');

// //     for (var song in widget.favs){
// //       favBox.add(favorite(
// //         title: song.title, 
// //         artist: song.artist ?? 'unknown',
// //         duration: song.duration ?? 0));
// //     }

// //     return ListView.builder(
// //       itemCount: widget.favs.length,
// //       itemBuilder: (context, index){
// //         return ListTile(
// //           contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),

// //           title: SizedBox(
// //             height: 18,
// //             child: Text((widget.favs[index].title).replaceAll('_', ' '),
// //             style: FontStyles.name,
// //             maxLines: 1,),
// //           ),

// //           subtitle: Text(widget.favs[index].artist ?? 'Unknown',
// //           style: FontStyles.artist,
// //           maxLines: 1,),

// //           leading: Container(
// //             padding: EdgeInsets.all(12),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(9),
// //               color: MyTheme().primaryColor
// //             ),
// //             child: Icon(Icons.music_note_rounded,
// //             color: Colors.white,),
// //           ),

// //           onTap: ()async {
// //             Navigator.push(context, MaterialPageRoute(builder: (context) => PlayingScreen(
// //               song: widget.favs[index], 
// //               audioPlayer: player
// //               )));}
// //         );
// //       });
// //   }
// // }

// // song_fav.dart
// import 'package:beatfusion/database/favorite.dart';
// import 'package:beatfusion/database/song.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:vibesync/database/model/model.dart';

// class Song_Fav extends StatefulWidget {
//   const Song_Fav({Key? key}) : super(key: key);

//   @override
//   State<Song_Fav> createState() => _Song_FavState();
// }

// class _Song_FavState extends State<Song_Fav> {
//   late Box<favorite>? songfavbox; // Make the Box nullable

//   @override
//   void initState() {
//     super.initState();
//     // No need to call openfavBox() here, FutureBuilder will handle it
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: Hive.openBox<favorite>('favoritesongsBox'),
//         builder: (context, AsyncSnapshot<Box<favorite>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No songs available'));
//           } else {
//             songfavbox = snapshot.data!;
//             return ListView.builder(
//               itemCount: songfavbox!.length,
//               itemBuilder: (context, index) {
//                 final songFavorite = songfavbox!.getAt(index);
//                 if (songFavorite != null) {
//                   return Container(
//                     height: 75,
//                     margin: const EdgeInsets.symmetric(vertical: 3),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 239, 235, 235),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Color.fromARGB(255, 17, 17, 17),
//                         child: Icon(
//                           Icons.music_note,
//                           color: Color.fromARGB(255, 226, 220, 220),
//                         ),
//                       ),
//                       title: Text(
//                         songFavorite.title,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: Color.fromARGB(255, 19, 18, 18),
//                         ),
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.favorite, color: Colors.red),
//                         onPressed: () {
//                           deleteSongFromFavorites(index);
//                         },
//                       ),
//                     ),
//                   );
//                 } else {
//                   return SizedBox();
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   void deleteSongFromFavorites(int index) {
//     songfavbox!.deleteAt(index);
//     setState(() {});
//   }
// }

// void openFavorite(Box<Song> songsBox, int index) async {
//   final boxFavoriteSongs = await Hive.openBox<favorite>('favoritesongsBox');
//   final song = songsBox.getAt(index);
//   if (song != null) {
//     final songFavorite = favorite(
//       title: song.name, 
//       artist: song.artist, 
//       duration: song.duration);
//     await boxFavoriteSongs.add(songFavorite);
//     print('Added to favorites: ${songFavorite.title}');
//   }
// }




import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
// import 'package:beatfusion/database/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        title: Text('Recent'),
      ),
      body: Center(
        child: Text('Favorite screen',style: FontStyles.greeting,),
      ),
    );
  }
}
