// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:beatfusion/database/song.dart';
// import 'package:beatfusion/database/favorite.dart';

// class FavoriteScreen extends StatefulWidget {
//   @override
//   _FavoriteScreenState createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   late Box<SongFavorite> _favoriteBox;

//   @override
//   void initState() {
//     super.initState();
//     _favoriteBox = Hive.box<SongFavorite>('song_favorite_box');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Songs'),
//       ),
//       body: FutureBuilder<List<Song>>(
//         future: _getFavoriteSongs(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('No favorite songs found.');
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data![index].name),
//                   subtitle: Text(snapshot.data![index].artist),
//                   // Add more UI elements as needed
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<List<Song>> _getFavoriteSongs() async {
//     SongFavorite? favoriteSongs = _favoriteBox.get(0);
//     return favoriteSongs?.song ?? [];
//   }
// }


// import 'package:beatfusion/database/favorite.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fav Screen '),
//       ),
//       body: FutureBuilder(
//         future: Hive.openBox<SongFavorite>('song_favorite_box'), 
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting){
//             return CircularProgressIndicator();
//           }else if(snapshot.hasError){
//             return Text('Error : ${snapshot.error}');
//           }else{
//             var FavBox = Hive.box<SongFavorite>('song_favorite_box');
//             var FavSongs = FavBox.get(0)?.song ?? [];

//             FavSongs = FavSongs.reversed.toList();

//             return ListView.builder(
//               itemCount: FavSongs.length,
//               itemBuilder: (context, index) {
//                 var song = FavSongs[index];
//                 return ListTile(
//                   title: Text(song.name),
//                   subtitle: Text(song.artist),
//                 );
//               },);
//           }
//         },),
//     );
//   }
// }




import 'package:beatfusion/database/favorite.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Screen'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<SongFavorite>('song_favorite_box'), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (!snapshot.hasData) {
            return Text('No data available'); // or some other UI indication
          } else {
            var favBox = Hive.box<SongFavorite>('song_favorite_box');
            var favSongs = favBox.get(0)?.song ?? [];

            favSongs = favSongs.reversed.toList();

            return ListView.builder(
              itemCount: favSongs.length,
              itemBuilder: (context, index) {
                var song = favSongs[index];
                return ListTile(
                  title: Text(song.name),
                  subtitle: Text(song.artist),
                );
              },
            );
          }
        },
      ),
    );
  }
}
