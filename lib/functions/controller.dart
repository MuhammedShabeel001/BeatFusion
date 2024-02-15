// import 'dart:js';

import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/history.dart';
// import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
// import 'package:beatfusion/screens/Library/playlist/playlistMusic.dart';
import 'package:beatfusion/widgets/Library/playlist/playlistMusic.dart';
import 'package:flutter/material.dart';
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
    
  } catch (e) {
    print('Error adding song to history: $e');
  }
}

void addList(BuildContext context){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: MyTheme().primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: Icon(
                  Icons.maximize_rounded,
                  size: 50.0,
                  color: MyTheme().secondaryColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  PlaylistScreen())); 
                  },
                  title: Text(
                    'Add to Playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.playlist_add,
                    color: MyTheme().selectedTile,
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Handle Add to Favorite action
                    addToFavoriteFunction();
                    Navigator.pop(context);
                  },
                  title: Text(
                    'Add to Favorite',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: MyTheme().selectedTile,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void addToFavoriteFunction() {
}


void addListPlaylist(BuildContext context){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: MyTheme().primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: Icon(
                  Icons.maximize_rounded,
                  size: 50.0,
                  color: MyTheme().secondaryColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    // Handle Add to Favorite action
                    addToFavoriteFunction();
                    Navigator.pop(context);
                  },
                  title: Text(
                    'Add to Favorite',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: MyTheme().selectedTile,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Remove from playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.delete,
                    color: MyTheme().selectedTile,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void PlaylistMenu(BuildContext context){
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          color: MyTheme().primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: Icon(
                  Icons.maximize_rounded,
                  size: 50.0,
                  color: MyTheme().secondaryColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Rename playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.edit,
                    color: MyTheme().selectedTile,
                  ),
                ),
                ListTile(
                  onTap: () {
                    // Handle Add to Favorite action
                    addToFavoriteFunction();
                    Navigator.pop(context);
                  },
                  title: Text(
                    'Delete Playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.delete,
                    color: MyTheme().selectedTile,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void showCompletionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Song Completed'),
        content: Text('The currently playing song has been completed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  // Future<void> showEditPlaylistDialog(BuildContext context, Playlist playlist) async {
  //   playlistNameController.text = playlist.name;

  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Edit Playlist Name'),
  //         content: TextField(
  //           controller: playlistNameController,
  //           decoration: InputDecoration(labelText: 'New Playlist Name'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               // Update the playlist name in the database
  //               final playlistBox = await Hive.openBox<Playlist>('playlists');
  //               final updatedPlaylist = Playlist(
  //                 name: playlistNameController.text,
  //                 song: playlist.song,
  //               );
  //               playlistBox.putAt(playlistBox.keys.toList().indexOf(playlist.key), updatedPlaylist);

  //               await playlistBox.close();
  //               Navigator.pop(context); // Close the dialog
  //               setState(() {}); // Update the UI
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }