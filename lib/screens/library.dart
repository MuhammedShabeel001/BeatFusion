import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/playlist/Playlist.dart';
import 'package:beatfusion/screens/favourite/fav_list.dart';
import 'package:beatfusion/screens/playlist2/playlistMusic.dart';
import 'package:beatfusion/screens/recent.dart';
import 'package:beatfusion/screens/recent/list_of_recentsongs.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({super.key});

  final List<String> itemNames = ['Favorite', 'Playlists', 'Recent'];

  void onTapFavorite(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
  }

  void onTapPlaylists(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  PlaylistScreen()));
  }

  void onTapHistory(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  RecentScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.0, 
          ),
          itemCount: itemNames.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
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


