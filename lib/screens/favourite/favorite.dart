// import 'package:beatfusion/database/favorite.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class ScreenFav extends StatefulWidget {
//   const ScreenFav({super.key});

//   @override
//   State<ScreenFav> createState() => _ScreenFavState();
// }

// class _ScreenFavState extends State<ScreenFav> {

//   final OnAudioQuery audioQuery = OnAudioQuery();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<SongModel>>(
//         future: OnAudioQuery().querySongs(
//           sortType: SongSortType.DATE_ADDED,
//           orderType: OrderType.ASC_OR_SMALLER,
//           uriType: UriType.EXTERNAL,
//           ignoreCase: true
//         ), 
//         builder: (context, snapshot){
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator(),);
//           }else if(snapshot.hasError){
//             return Center(child: Text('Error: ${snapshot.error}'),);
//           }else{
//             final List<SongModel> favSong = snapshot.data!;
//             return ScreenFav();
//           }
//         }),
//     );
//   }
// }




























// import 'package:beatfusion/common/text_style.dart';
// import 'package:beatfusion/common/theme.dart';
// import 'package:beatfusion/database/favorite.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:vibesync/database/model/model.dart';

// class Song_Fav extends StatefulWidget {
//   const Song_Fav({Key? key}) : super(key: key);

//   @override
//   State<Song_Fav> createState() => _Song_FavState();
// }

// class _Song_FavState extends State<Song_Fav> {
//   late Box<SongFavorite>? songfavbox; // Make the Box nullable

//   @override
//   void initState() {
//     super.initState();
//     // No need to call openfavBox() here, FutureBuilder will handle it
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyTheme().primaryColor,
//       appBar: AppBar(
//         title: Text('Favorite',style: FontStyles.greeting,),
//         leading: IconButton(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           onPressed: (){
//             Navigator.pop(context);
//           }, 
//           icon: SvgPicture.asset('assets/pics/back.svg'),
//           ),
//       ),
//       body: Container(
//         color: MyTheme().primaryColor,
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.all(10),
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: MyTheme().secondaryColor,
//           ),
//           child: FutureBuilder(
//         future: Hive.openBox<SongFavorite>('favoritesongsBox'),
//         builder: (context, AsyncSnapshot<Box<SongFavorite>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Return a loading indicator while the box is being opened
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // Handle error if box opening fails
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             // Handle case where box is empty
//             return Center(child: Text('No songs available',style: FontStyles.name,));
//           } else {
//             // Box opened successfully, assign the box to songfavbox
//             songfavbox = snapshot.data!;

//             return ListView.builder(
//               itemCount: songfavbox!.length,
//               itemBuilder: (context, index) {
//                 final songFavorite = songfavbox!.getAt(index);
//                 if (songFavorite != null) {
//                   return ListTile(
//                     contentPadding: EdgeInsets.all(0),
//                       leading: Container(
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(9),
//                           color: MyTheme().primaryColor
//                         ),
//                         child: Icon(Icons.music_note_rounded,
//                         color: Colors.white,),
//                       ),
//                       title: Text(
//                         songFavorite.name,
//                         //    songs[index].title,
//                         overflow: TextOverflow.ellipsis,
//                         style: FontStyles.name
//                       ),
//                       subtitle: Text(
//                         songFavorite.artist,
//                         overflow: TextOverflow.ellipsis,
//                         style: FontStyles.artist,
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.remove, color: MyTheme().iconColor),
//                         onPressed: () {
//                           deleteSongFromFavorites(index);
//                         },
//                       ),
//                     );
                  
//                 } else {
//                   return SizedBox();
//                 }
//               },
//             );
//           }
//         },
//       ),
//         ),
//       ),
//     );
//   }

//   void deleteSongFromFavorites(int index) {
//     songfavbox!.deleteAt(index);
//     setState(() {});
//   }
// }


