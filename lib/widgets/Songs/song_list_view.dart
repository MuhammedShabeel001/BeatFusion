import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/Playing/playing.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListView extends StatefulWidget {
  final List<SongModel> songs;

  const SongListView({super.key, required this.songs} );

  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {
    int currentSongID = 0;
    Box<Song>? boxsong;
    final AudioPlayer player = AudioPlayer();
  @override

  void initState(){
    super.initState();
    openSongs();
  }
  
  void openSongs(){
  // ignore: unrelated_type_equality_checks
  boxsong!=Hive.openBox<Song>('songbox');
  }

  @override
  Widget build(BuildContext context) {
    final songBox = Hive.box<Song>('songsbox');

    for (var song in widget.songs) {
      if (songBox.get(song.id) == null) {
        songBox.put(song.id, Song(
          key: song.id, 
          name: song.title, 
          artist: song.artist ?? 'unknown', 
          duration: song.duration ?? 0, 
          filePath: song.data));
      }
    }

    return ListView.builder(
      itemCount: songBox.length,
      itemBuilder: (context, index) {
      final song=songBox.getAt(index);
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),

            title: SizedBox(
              height: 18,
              child: Text(
                song!.name,
              style: FontStyles.name,
              maxLines: 1,),
            ),
            subtitle: Text( song.artist,
              style: FontStyles.artist,
              maxLines: 1,),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: MyTheme().primaryColor
              ),
              child: const Icon(Icons.music_note_rounded,
                color: Colors.white,),
            ),
            trailing: IconButton(
              onPressed: () => addList(context,song,),
              icon: Icon(Icons.more_vert,
                color: MyTheme().iconColor,)),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    PlayingScreen(
                      songdata: Song(key: song.key, name: song.name, artist: song.artist, duration: song.duration, filePath: song.filePath),
                      audioPlayer: player,
                ),
              ),
            );
          }, 
        );
      },
    );
  }
}