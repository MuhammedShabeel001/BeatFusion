import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/database/favorite.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Box<SongFavorite> _favoriteBox;

  @override
  void initState() {
    super.initState();
    _favoriteBox = Hive.box<SongFavorite>('song_favorite_box');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
      ),
      body: FutureBuilder<List<Song>>(
        future: _getFavoriteSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No favorite songs found.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].artist),
                  // Add more UI elements as needed
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Song>> _getFavoriteSongs() async {
    SongFavorite? favoriteSongs = _favoriteBox.get(0);
    return favoriteSongs?.song ?? [];
  }
}
