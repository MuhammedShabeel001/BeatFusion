import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Adjust the import based on your project structure

class FavoriteSongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
        // Customize your app bar as needed
      ),
      body: FutureBuilder(
        future: Hive.openBox<SongFavorite>('FavouriteSong'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var favoriteBox = Hive.box<SongFavorite>('FavouriteSong');
            var favoriteSongs = favoriteBox.get(0)?.song ?? [];

            return ListView.builder(
              itemCount: favoriteSongs.length,
              itemBuilder: (context, index) {
                var song = favoriteSongs[index];

                return ListTile(
                  title: Text(
                    song.name,
                    style: FontStyles.name2,
                  ),
                  subtitle: Text(
                    song.artist,
                    style: FontStyles.artist2,
                  ),
                  // Add other song details as needed
                );
              },
            );
          } else {
            // Handle loading state
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
