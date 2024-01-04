import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/playlist/Playlist.dart';
import 'package:beatfusion/screens/favourite/fav_list.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPlayListView extends StatefulWidget {
  final List<SongModel> songs;

  const SongPlayListView({super.key, required this.songs} );

  @override
  State<SongPlayListView> createState() => _SongPlayListViewState();
}

class _SongPlayListViewState extends State<SongPlayListView> {
    int currentSongID = 0;
    Box<Song>? boxsong;
    final AudioPlayer player = AudioPlayer();
  @override
 void initState(){
  super.initState();
  openSongs();
}
  


  void addToPlaylistFunction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const playlistScreen(),));
    print('Added to Playlist');
  }

  void addToFavoriteFunction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()  ,));
    print('Added to Favorite');
  }

  void openSongs(){
  // ignore: unrelated_type_equality_checks
  boxsong!=Hive.openBox<Song>('songbox');
    print('..................................${boxsong}');
  }

  void _changePlayerVisibility() {
      setState(() {
        isPlayerViewVisible = true;
      });
  }

  void _updateSongDetails(int index) {
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentIndex = index;
        currentSongID = songs[index].id;
        currentArtist = songs[index].artist;
        isPlaying = true;
      }
    });
  }

  Set<int> selectedSongs = Set<int>();

  @override
  Widget build(BuildContext context) {
    final songBox = Hive.box<Song>('songsbox');
    print(songBox.length);

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
            onPressed: () {
              setState(() {
                if (selectedSongs.contains(index)) {
                  selectedSongs.remove(index);
                } else {
                  selectedSongs.add(index);
                }
              });
            },
            icon: Icon(
              selectedSongs.contains(index) ? Icons.check_box : Icons.add,
              color: MyTheme().iconColor,
            ),
          ),
          onTap: () async {
            // Handle tap actions here
            _updateSongDetails(index);
            _changePlayerVisibility();
          },
         
        );

        

        
      },
    );
  }
  

}