import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/Playlist.dart';
import 'package:beatfusion/screens/favourite/fav_list.dart';
import 'package:beatfusion/screens/favourite/favorite.dart';
import 'package:beatfusion/screens/recent.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({Key? key});

  final List<String> itemNames = ['Favorite', 'Playlists', 'History'];

  void onTapFavorite(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
    // Add your logic for the 'Favorite' grid item here
  }

  void onTapPlaylists(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => playlistScreen()));
    // Add your logic for the 'Playlists' grid item here
  }

  void onTapHistory(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RecentScreen()));
    // Add your logic for the 'History' grid item here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.0, // Adjust the value to set the height
          ),
          itemCount: itemNames.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Execute different functions based on the tapped index
                switch (index) {
                  case 0:
                    onTapFavorite(context);
                    break;
                  case 1:
                    onTapPlaylists(context);
                    break;
                  case 2:
                    onTapHistory(context);
                    break;
                  default:
                    break;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: MyTheme().tileColor,
                ),
                child: Center(
                  child: Text(
                    itemNames[index],
                    style: FontStyles.tile,
                    maxLines: 1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


