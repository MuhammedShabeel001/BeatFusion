import 'package:beatfusion/database/playlist.dart'; // Update with the correct import path
import 'package:beatfusion/screens/playlist2/MusicplaylistPage.dart';
import 'package:beatfusion/screens/playlist2/playlistDetails.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Screen'),
      ),
      body: FutureBuilder<Box<Playlist>>(
        future: Hive.openBox<Playlist>('playlists'), // Assuming 'playlists' is the box name
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No playlists available'));
          } else {
            final playlistBox = snapshot.data!;

            return ListView.builder(
              itemCount: playlistBox.length,
              itemBuilder: (context, index) {
                final playlist = playlistBox.getAt(index);

                return ListTile(
                  title: Text(playlist!.name),
                  subtitle: Text('Song Count: ${playlist.song.length}'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistDetailScreen(playlist),));
                    // Navigate to the detailed playlist screen or perform other actions
                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistDetailScreen(playlist)));
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show the Add Playlist dialog
          final result = await showAddPlaylistDialog(context);

          // Check the result and refresh the screen if needed
          
            // Refresh the screen by calling setState
            setState(() {});
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}