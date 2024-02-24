// import 'dart:js';

import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/playlist.dart';
// import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
// import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/widgets/Library/playlist/MusicplaylistPage.dart';
import 'package:beatfusion/widgets/Library/playlist/playlistDetails.dart';
import 'package:beatfusion/widgets/Library/playlist/playlistMusic.dart';
// import 'package:beatfusion/screens/Library/playlist/playlistMusic.dart';
// import 'package:beatfusion/widgets/Library/playlist/playlistMusic.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void addToHistory(Song song) async {
  try {
    var historyBox = await Hive.openBox<SongHistory>('history');

    // Get the existing list of recent songs from the SongHistory box
    var recentSongs = historyBox.get(0)?.RecentSong ?? [];
    int existingIndex = recentSongs.indexWhere((element) => element.key == song.key);

    if (existingIndex != -1) {
      recentSongs.removeAt(existingIndex);
    }

    // Add the current song to the list
    recentSongs.add(Song(
      key: song.key,
      name: song.name,
      artist: song.artist,
      duration: song.duration,
      filePath: song.filePath,
    ));

    // Update the SongHistory box with the new list
    historyBox.put(0, SongHistory(RecentSong: recentSongs));

    // Close the SongHistory box
    await historyBox.close();
    
  } catch (e) {
    print('Error adding song to history: $e');
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
    if (isInFavorites(songdata)) {
      removeFromFavorite(songdata);
    }else{
      addToFavorite(songdata);
    }
  },
  title: Text( 
    isInFavorites(songdata) ? 'Remove from Favorites' : 'Add to Favorites',  
    style: FontStyles.order,
  ),
  leading: Icon(
    isInFavorites(songdata) ? Icons.favorite : Icons.favorite_border,
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

void addToFavorite(Song song) async {
  final Box<SongFavorite> favoriteBox = Hive.box<SongFavorite>('favoriteBox');

  // Retrieve the existing list of songs from the favorite box
  List<Song> currentSongs = favoriteBox.get(0)?.song ?? [];

  // Check if the song is not already in the favorite list
  if (!currentSongs.contains(song)) {
    // Add the song to the list
    currentSongs.add(song);

    // Save the updated list to the favorite box
    await favoriteBox.put(0, SongFavorite(song: currentSongs));

    // Optionally, you can display a message or perform any other actions
    print('Song added to Favorites!');
  } else {
    // Optionally, you can display a message or perform any other actions
    print('Song is already in Favorites!');
  }
}


void removeFromFavorite(Song song) async {
  final Box<SongFavorite> favoriteBox = Hive.box<SongFavorite>('favoriteBox');

  // Retrieve the existing list of songs from the favorite box
  List<Song> currentSongs = favoriteBox.get(0)?.song ?? [];

  // Check if the song is in the favorite list
  if (currentSongs.contains(song)) {
    // Remove the song from the list
    currentSongs.remove(song);

    // Save the updated list to the favorite box
    await favoriteBox.put(0, SongFavorite(song: currentSongs));

    // Optionally, you can display a message or perform any other actions
    print('Song removed from Favorites!');
  } else {
    // Optionally, you can display a message or perform any other actions
    print('Song is not in Favorites!');
  }
}

bool isInFavorites(Song song) {
  final Box<SongFavorite> favoriteBox = Hive.box<SongFavorite>('FavouriteSong');
  List<Song> currentSongs = favoriteBox.get(0)?.song ?? [];
  return currentSongs.contains(song);
}


// void addToFavorite(Song song) async {
//   final Box<SongFavorite> favoriteBox = Hive.box<SongFavorite>('favoriteBox');

//   // Retrieve the existing list of songs from the favorite box
//   List<Song> currentSongs = favoriteBox.get(0)?.song ?? [];

//   // Check if the song is already in the favorite list
//   if (currentSongs.contains(song)) {
//     // Remove the song from the list
//     currentSongs.remove(song);

//     try {
//       // Save the updated list to the favorite box
//       await favoriteBox.put(0, SongFavorite(song: currentSongs));

//       // Display feedback to the user
//       print('Song removed from Favorites!');
//     } catch (e) {
//       // Handle any potential exceptions during Hive operations
//       print('Error removing song from Favorites: $e');
//     }
//   } else {
//     // Add the song to the list using spread operator for immutability
//     currentSongs = [...currentSongs, song];

//     try {
//       // Save the updated list to the favorite box
//       await favoriteBox.put(0, SongFavorite(song: currentSongs));

//       // Display feedback to the user
//       print('Song added to Favorites!');
//     } catch (e) {
//       // Handle any potential exceptions during Hive operations
//       print('Error adding song to Favorites: $e');
//     }
//   }
// }



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
                    // Handle Add to Favorite action
                    addToFavorite(songdata);
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

void PlaylistMenu(BuildContext context,Playlist playlist,VoidCallback refreshScreen){
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

void showCompletionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Song Completed'),
        content: Text('The currently playing song has been completed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  // Future<void> showEditPlaylistDialog(BuildContext context, Playlist playlist) async {
  //   playlistNameController.text = playlist.name;

  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Edit Playlist Name'),
  //         content: TextField(
  //           controller: playlistNameController,
  //           decoration: InputDecoration(labelText: 'New Playlist Name'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               // Update the playlist name in the database
  //               final playlistBox = await Hive.openBox<Playlist>('playlists');
  //               final updatedPlaylist = Playlist(
  //                 name: playlistNameController.text,
  //                 song: playlist.song,
  //               );
  //               playlistBox.putAt(playlistBox.keys.toList().indexOf(playlist.key), updatedPlaylist);

  //               await playlistBox.close();
  //               Navigator.pop(context); // Close the dialog
  //               setState(() {}); // Update the UI
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // import 'package:flutter/material.dart';
// import 'package:beatfusion/common/theme.dart'; // Import your theme class
// import 'package:hive/hive.dart'; // Import Hive for accessing the data

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:beatfusion/database/playlist.dart'; // Import your Playlist model

void showPlaylistBottomSheet(BuildContext context) {
  showModalBottomSheet(
    // backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<Box<Playlist>>(
        future: Hive.openBox<Playlist>('playlists'),
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
                  title: Text(
                    playlist!.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    // Handle the tap on a playlist
                    // You can perform any action here, such as navigating to the playlist details screen
                    print('Tapped on playlist: ${playlist.name}');
                    Navigator.pop(context); // Close the bottom sheet
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


// void playlistBottom(BuildContext context){
//   showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context, 
//     builder: (BuildContext context) {
//       return Container(
//         // height: MediaQuery.of(context).size.height * 0.23,
//         decoration: BoxDecoration(
          
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           color: MyTheme().primaryColor
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               bottom: 0,
//               right: 0,
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 20, top: 10),
//                 child: Icon(
//                   Icons.maximize_rounded,
//                   size: 50,
//                   color: MyTheme().secondaryColor,
//                 ),
//               )),
//               Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ListTile(
//                     onTap: (){},
//                     title: Text(
//                       'Add new playlist',
//                       style: FontStyles.order,
//                     ),
//                     leading: Icon(
//                       Icons.add,
//                       color: MyTheme().selectedTile,
//                     ),
//                   ),
//                   FutureBuilder<Box<Playlist>>(
//                     future: Hive.openBox<Playlist>('playlists'), 
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No playlists available'));
//           } else{
//             final playlistBox = snapshot.data!;

//             return ListView.builder(
//               itemCount: playlistBox.length,
//               itemBuilder: (context, index) {
//                 final playlist = playlistBox.getAt(index);

//                 return ListTile(
//                   title: Text(playlist!.name,style: FontStyles.name,),
//                   leading: Icon(Icons.folder,color: MyTheme().tertiaryColor,),
//                 );
//               },);
//           }
//                     },)
//                 ],
//               )
//           ],
//         ),
//       );
//     },);
// }


void playlistBottom(BuildContext context,Song songdata) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: 20), // Adjust the top margin
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: MyTheme().primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Set to min to take up only the necessary space
          children: [
            Icon(
                  Icons.maximize_rounded,
                  size: 50.0,
                  color: MyTheme().secondaryColor,
                ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistScreen(),),
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
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No playlists available'));
                } else {
                  final playlistBox = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true, // Allow the ListView to shrink-wrap
                    itemCount: playlistBox.length,
                    itemBuilder: (context, index) {
                      final playlist = playlistBox.getAt(index);

                      return ListTile(
                        onTap: () {
                          // addToPlaylist(playlist.name,songdata);
                          // PlaylistMenu(context, playlist, () { });
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
                  child: Text(
                    'Rename',
                    style: TextStyle(color: MyTheme().primaryColor),
                  ),
                  onPressed: isButtonEnabled
                      ? () async {
                          String newPlaylistName =
                              playlistNameController.text.trim();

                          if (newPlaylistName != oldName) {
                            final playlistBox =
                                await Hive.openBox<Playlist>('playlists');

                            // Update playlist name in Hive
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

                          Navigator.of(context).pop();
                          refreshScreen();
                          setState(() {
                            // refreshScreen();
                          });
                        }
                      : null,
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
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete the playlist "${playlistName}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Delete playlist from Hive
              final playlistBox = await Hive.openBox<Playlist>('playlists');
              await playlistBox.delete(playlistName);
              await playlistBox.close();

              // Update the UI
              refreshScreen();
              // setState(() {});

              // Close the dialog
              Navigator.of(context).pop();
          
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog without deleting the playlist
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}



// Future<void> addToPlaylist(String playlistName, Song currentSong) async {
//   var playlistBox = await Hive.openBox<Playlist>('playlists');

//   var selectedPlaylist = playlistBox.values.firstWhere(
//     (playlist) => playlist.name == playlistName,
//     orElse: () => null as Playlist,
//   );

//   if (selectedPlaylist != null) {
//     // Make sure to check if the song is not already in the playlist
//     if (!selectedPlaylist.song.contains(currentSong)) {
//       selectedPlaylist.song.add(currentSong);
//       playlistBox.put(selectedPlaylist.name, selectedPlaylist);
//     }
//   }

//   await playlistBox.close();
// }


