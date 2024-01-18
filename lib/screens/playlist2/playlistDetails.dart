import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:beatfusion/screens/playlist/Playlist.dart';
import 'package:flutter/material.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final Playlist playlist;

  const PlaylistDetailScreen(this.playlist);

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final AudioPlayer player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Detail Screen'),
      ),
      body: ListView.builder(
        itemCount: widget.playlist.song.length,
        itemBuilder: (context, index) {
          final song = widget.playlist.song[index];
          return ListTile(
            title: Text(song.name),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayingScreen(songdata: 
              // song.filePath,
              Song(key: song.key, name: song.name, artist: song.artist, duration: song.duration, filePath: song.filePath),
               audioPlayer: player),));
            },
            trailing: IconButton(onPressed: (){}, icon:Icon(Icons.close),color: Colors.red,),
            // Add more information or actions related to each song if needed
          );
        },
      ),
    );
  }
}