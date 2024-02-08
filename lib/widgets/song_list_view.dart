import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/playlist/Playlist.dart';
import 'package:beatfusion/screens/favourite/fav_list.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
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
  
addList() {
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
                    // Handle Add to Playlist action
                    Navigator.push(context, MaterialPageRoute(builder: (context) => playlistScreen(),));
                    // Navigator.pop(context);
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
            onPressed: () => addList(), 
            icon: Icon(Icons.more_vert,
            color: MyTheme().iconColor,)),

          onTap: () async {
  // Open the SongHistory Hive box
  var historyBox = await Hive.openBox<SongHistory>('history');

  // Get the current song from the SongBox
  var song = songBox.getAt(index);

  // Get the existing list of recent songs from the SongHistory box
  var recentSongs = historyBox.get(0)?.RecentSong ?? [];

  // Add the current song to the list
  recentSongs.add(Song(
    key: song!.key,
    name: song.name,
    artist: song.artist,
    duration: song.duration,
    filePath: song.filePath,
  ));

  // Update the SongHistory box with the new list
  historyBox.put(0, SongHistory(RecentSong: recentSongs));

  // Close the SongHistory box
  await historyBox.close();

  // Navigate to the PlayingScreen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
      //  PlayingScreen(
      //   songs: [], 
      //   currentIndex: currentIndex, 
      //   audioPlayer: player)
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




// User
// in the above provided code only one song is listed down/storing to hive field 
// I need the code to add every song to the hive field