import 'package:beatfusion/database/playlist.dart'; // Update with the correct import path
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistScreen extends StatelessWidget {
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
        onPressed: () {
          showAddPlaylistDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddPlaylistDialog(BuildContext context) {
    // Implement the logic to show a dialog for adding a new playlist
    // For example, using the showDialog method
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Playlist'),
          // Add the form fields or input widgets for playlist name and songs
          // Implement the logic to add the new playlist to the box
          // Update the UI accordingly
        );
      },
    );
  }
}
