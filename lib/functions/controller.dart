import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/widgets/Library/playlist/musicplaylist_page.dart';
import 'package:beatfusion/widgets/Library/playlist/playlist_details.dart';
import 'package:beatfusion/widgets/Library/playlist/playlist_music.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

void addToHistory(Song song) async {
  try {
    var historyBox = await Hive.openBox<SongHistory>('history');
    var recentSongs = historyBox.get(0)?.RecentSong ?? [];
    int existingIndex = recentSongs.indexWhere((element) => element.key == song.key);

    if (existingIndex != -1) {
      recentSongs.removeAt(existingIndex);
    }

    recentSongs.add(Song(
      key: song.key,
      name: song.name,
      artist: song.artist,
      duration: song.duration,
      filePath: song.filePath,
    ));
    historyBox.put(0, SongHistory(RecentSong: recentSongs));

    await historyBox.close();
    
  // ignore: empty_catches
  } catch (e) {
  }
}

void addList(BuildContext context,Song songdata){
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
                  onTap: () { Navigator.pop(context);
                  playlistBottom(context, songdata);},
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
    Navigator.pop(context);
    toggleFavorite(context, songdata);
  },
  title: Text( 
     'Add to Favorites',  
    style: FontStyles.order,
  ),
  leading: Icon(
     Icons.favorite ,
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

void toggleFavorite(BuildContext context, Song song) async {
  var favoriteBox = await Hive.openBox<SongFavorite>('FavouriteSong');
  var favoriteSongs = favoriteBox.get(0)?.song ?? [];

  bool isFavorite = favoriteSongs.any((s) => s.filePath == song.filePath);

  if (isFavorite) {
    favoriteSongs.removeWhere((s) => s.filePath == song.filePath);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Removed from Favorites',
          style: FontStyles.artist2,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: const Color.fromARGB(131, 64, 66, 88),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  } else {
    favoriteSongs.add(song);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added to Favorites',
          style: FontStyles.artist2,
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: const Color.fromARGB(131, 64, 66, 88),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }

  favoriteBox.put(0, SongFavorite(song: favoriteSongs));
}

void addListPlaylist(BuildContext context,Song songdata){
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
                    toggleFavorite(context, songdata);
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
                ListTile(
                  onTap: () {},
                  title: Text(
                    'Remove from playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.delete,
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

void playlistMenu(BuildContext context,Playlist playlist,VoidCallback refreshScreen){
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
                    Navigator.pop(context);
                    renamePlaylist(context, playlist.name, refreshScreen);
                  },
                  title: Text(
                    'Rename playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.edit,
                    color: MyTheme().selectedTile,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    deletePlaylist(context, playlist.name,refreshScreen);
                  },
                  title: Text(
                    'Delete Playlist',
                    style: FontStyles.order,
                  ),
                  leading: Icon(
                    Icons.delete,
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

void showPlaylistBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<Box<Playlist>>(
        future: Hive.openBox<Playlist>('playlists'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No playlists available'));
          } else {
            final playlistBox = snapshot.data!;

            return ListView.builder(
              itemCount: playlistBox.length,
              itemBuilder: (context, index) {
                final playlist = playlistBox.getAt(index);

                return ListTile(
                  title: Text(
                    playlist!.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
      );
    },
  );
}

void playlistBottom(BuildContext context,Song songdata) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin:const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius:const BorderRadius.vertical(top: Radius.circular(30)),
          color: MyTheme().primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                  Icons.maximize_rounded,
                  size: 50.0,
                  color: MyTheme().secondaryColor,
                ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaylistScreen(),),
                );
                showAddPlaylistDialog(context);
              },
              title: Text(
                'Add new playlist',
                style: FontStyles.order,
              ),
              leading: Icon(
                Icons.add,
                color: MyTheme().selectedTile,
              ),
            ),
            FutureBuilder<Box<Playlist>>(
              future: Hive.openBox<Playlist>('playlists'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No playlists available'));
                } else {
                  final playlistBox = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: playlistBox.length,
                    itemBuilder: (context, index) {
                      final playlist = playlistBox.getAt(index);

                      return ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistDetailScreen(playlist)));
                        },
                        title: Text(
                          playlist!.name,
                          style: FontStyles.name,
                        ),
                        leading: Icon(
                          Icons.folder,
                          color: MyTheme().tertiaryColor,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

  Future<void> renamePlaylist(BuildContext context, String oldName, VoidCallback refreshScreen) async {
    TextEditingController playlistNameController =
        TextEditingController(text: oldName);
    bool isButtonEnabled = true;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: MyTheme().tertiaryColor,
              title: Text(
                'Rename Playlist',
                style: TextStyle(color: MyTheme().primaryColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: playlistNameController,
                    onChanged: (text) {
                      setState(() {
                        isButtonEnabled = text.trim().isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter new playlist name',
                      errorText: isButtonEnabled ? null : '',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: MyTheme().secondaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          String newPlaylistName =
                              playlistNameController.text.trim();

                          if (newPlaylistName != oldName) {
                            final playlistBox =
                                await Hive.openBox<Playlist>('playlists');

                            final Playlist? existingPlaylist =
                                playlistBox.get(oldName);

                            if (existingPlaylist != null) {
                              final updatedPlaylist = Playlist(
                                name: newPlaylistName,
                                song: existingPlaylist.song,
                              );
                              playlistBox.put(newPlaylistName, updatedPlaylist);
                              await playlistBox.delete(oldName);
                            }

                            await playlistBox.close();
                          }

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          refreshScreen();
                          setState(() {
                          });
                        }
                      : null,
                  child: Text(
                    'Rename',
                    style: TextStyle(color: MyTheme().primaryColor),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> deletePlaylist(BuildContext context, String playlistName,VoidCallback refreshScreen) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete the playlist "$playlistName"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              final playlistBox = await Hive.openBox<Playlist>('playlists');
              await playlistBox.delete(playlistName);
              await playlistBox.close();

              refreshScreen();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
          
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

void favouriteList(BuildContext context,Song songdata,VoidCallback refreshFavouriteScreen){
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
                  onTap: () { Navigator.pop(context);
                  playlistBottom(context, songdata);},
                  //  PlaylistBottom(context),
                  // showPlaylistBottomSheet(context),
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
    Navigator.pop(context);
    toggleFavorite(context, songdata);
    refreshFavouriteScreen();
  },
  title: Text( 
     'Remove From Favorites',  
    style: FontStyles.order,
  ),
  leading: Icon(
     Icons.favorite ,
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


final OnAudioQuery onAudioQuery = OnAudioQuery();
Future<void> fetchSongs() async {
  await onAudioQuery.permissionsStatus();
  final songs = await onAudioQuery.querySongs();

  final songBox = await Hive.openBox<Song>('songs');

  for (final song in songs) {
    final hiveSong = Song(key: song.id, name: song.displayName, artist: song.artist??'unknown', duration: song.duration??0, filePath: song.data);

    await songBox.put(song.id, hiveSong);
  }
}