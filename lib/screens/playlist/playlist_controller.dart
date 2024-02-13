import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/screens/playlist/list_of_playlist.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void showalert(BuildContext context) {
  TextEditingController playlistNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Name Your Playlist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: playlistNameController,
              decoration: InputDecoration(labelText: 'Playlist Name'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String playlistName = playlistNameController.text;
                    final playlistBox = await Hive.openBox<Playlist>('playlistBox');
                    playlistBox.add(Playlist(name: playlistName, song: []));
                    print('Playlist Name: $playlistName');

                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistList(),
                      ),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}