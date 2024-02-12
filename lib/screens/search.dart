import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/playlist/Playlist.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _searchController = TextEditingController();
  late Box<Song> songBox;
  List<Song> searchResults = [];

  final AudioPlayer player = AudioPlayer();

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
  // Add your logic for adding to playlist here
  print('Added to Playlist');
}

void addToFavoriteFunction() {
  print('Added to Favorite');
}

  @override
  void initState() {
    super.initState();
    songBox = Hive.box<Song>('songsbox');

    performSearch();
  }

  List<Song> searchSongs(String query) {
    return songBox.values
        .where((song) =>
            song.name.toLowerCase().contains(query.toLowerCase()) ||
            song.artist.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void performSearch() {
    String query = _searchController.text.trim();
    List<Song> newSearchResults = searchSongs(query);

    setState(() {
      searchResults = newSearchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(actions: [IconButton(onPressed: (){}, icon: Icon(Icons.refresh_rounded))],),
      backgroundColor: MyTheme().primaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          color: MyTheme().primaryColor,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyTheme().secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        cursorColor: MyTheme().secondaryColor,
                        controller: _searchController,
                        onChanged: (query) {
                          performSearch(); // Start searching while typing
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          fillColor: MyTheme().secondaryColor,
                          hintText: 'Search...',
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: performSearch,
                            icon: const Icon(Icons.search, color: Colors.grey),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyTheme().secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: searchResults.isNotEmpty
                        ? ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final Song song = searchResults[index];
                              return ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: MyTheme().primaryColor
                                  ),
                                  child: const Icon(Icons.music_note_rounded,
                                  color: Colors.white,),
                                ),
                                title: Text(
                                  song.name,
                                  style: FontStyles.name,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  song.artist,
                                  style: FontStyles.artist,
                                  maxLines: 1,
                                ),
                                trailing: IconButton(
                                  onPressed: () => addList(), 
                                  icon: const Icon(Icons.more_vert,
                                  color: Colors.white,),
                              ),
                              onTap: ()async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => 
        //                         PlayingScreen(
        // songs: [], 
        // currentIndex: currentIndex, 
        // audioPlayer: player)
                                PlayingScreen(
                                  // songdata: song.filePath,
                                  songdata: Song(key: song.key, name: song.name, artist: song.artist, duration: song.duration, filePath: song.filePath), 
                                  audioPlayer: player
                                  )
                                  ));

                              },
                              );

                            }
                          )
                        : const Center(
                            child: Text(
                              'No songs found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}