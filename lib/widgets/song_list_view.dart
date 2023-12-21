import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/Playlist.dart';
import 'package:beatfusion/screens/favourite/fav_list.dart';
// import 'package:beatfusion/screens/favorite.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:beatfusion/screens/test.dart';
// import 'package:beatfusion/functions/control_functions.dart';
// import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'song.dart';

class SongListView extends StatefulWidget {
  final List<SongModel> songs;

  SongListView({required this.songs});

  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {
  // bool isPlaying = false;
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
                    addToPlaylistFunction();
                    Navigator.pop(context);
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

// Function to handle Add to Playlist action
void addToPlaylistFunction() {
  Navigator.push(context, MaterialPageRoute(builder: (context) => playlistScreen(),));
  // Add your logic for adding to playlist here
  print('Added to Playlist');
}

// Function to handle Add to Favorite action
void addToFavoriteFunction() {
  // Add your logic for adding to favorite here
  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()  ,));
  print('Added to Favorite');
}

void openSongs(){
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
    final songBox = Hive.box<Song>('songs');
    print(songBox.length);

    for (var song in widget.songs) {
      songBox.add(Song(
        key: song.id,
        name: song.title,
        artist: song.artist ?? 'Unknown',
        duration: song.duration ?? 0,
        // artWorkUrl: '',
        filePath: song.data
      ));
    }

    return ListView.builder(
      itemCount: songBox.length,
      itemBuilder: (context, index) {
        final song=songBox.getAt(index);
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),

          title: SizedBox(
            height: 18,
            child: Text(
              song!.name,
              
              //(widget.songs[index].title).replaceAll('_', ' '),
            style: FontStyles.name,
            maxLines: 1,),
          ),

          subtitle: Text( song!.artist,
            //widget.songs[index].artist ?? 'Unknown',
          style: FontStyles.artist,
          maxLines: 1,),

          leading: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: MyTheme().primaryColor
            ),
            child: Icon(Icons.music_note_rounded,
            color: Colors.white,),
          ),

          trailing: IconButton(
            onPressed: () => addList(), 
            icon: Icon(Icons.more_vert,
            color: MyTheme().iconColor,)),

          onTap: ()async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PlayingScreen(
              songdata: song.filePath, 
              audioPlayer: player
              )));
            
          },
         
        );

        

        
      },
    );
  }


}