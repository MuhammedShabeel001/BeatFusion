import 'package:beatfusion/screens/playlist2/MusicplaylistPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
// import 'package:your_project/models/playlist.dart'; // Update with the correct import path

class PlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Screen'),
      ),
      body: Center(
        child: Text('Your playlist content goes here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPlaylistDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  
}
