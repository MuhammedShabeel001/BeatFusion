

import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/screens/playlist/playlist_songs.dart';
import 'package:beatfusion/screens/playlist2/songsPLaylist.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> showAddPlaylistDialog(BuildContext context) async {
  TextEditingController playlistNameController = TextEditingController();
  bool isButtonEnabled = false;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        
        // backgroundColor: MyTheme().tertiaryColor,
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: MyTheme().tertiaryColor,
            title: Text('Add Playlist',style: TextStyle(color: MyTheme().primaryColor),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: playlistNameController,
                  onChanged: (text) {
                    setState(() {
                      // Enable the button only if the text field is not empty
                      isButtonEnabled = text.trim().isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter playlist name',
                    errorText: isButtonEnabled ? null : '',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',style: TextStyle(color: MyTheme().secondaryColor),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Add',),
                onPressed: isButtonEnabled
                    ? () {
                        // Get the entered playlist name
                        String playlistName =
                            playlistNameController.text.trim();

                        // // Create a new playlist object
                        // Playlist newPlaylist =
                        //     Playlist(name: playlistName, song: []);

                        // // Store the playlist in Hive
                        // var playlistBox = Hive.box<Playlist>('playlists');
                        // playlistBox.add(newPlaylist);

                        // // Close the dialog
                        Navigator.of(context).pop();

                        // Navigate to the new screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SongsPlayList(ListName: playlistName)),
                        );
                      }
                    : null,
              ),
            ],
          );
        },
      );
    },
  );
}