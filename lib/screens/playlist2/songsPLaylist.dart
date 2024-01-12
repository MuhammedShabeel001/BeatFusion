import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/playlist2/listOfPLaylistSongs.dart';
import 'package:beatfusion/widgets/song_list_view.dart';
import 'package:beatfusion/database/song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SongsPlayList extends StatefulWidget {
  String ListName;
  SongsPlayList({Key? key, required this.ListName}) : super(key: key);

  @override
  State<SongsPlayList> createState() => _SongsPlayListState();
}

class _SongsPlayListState extends State<SongsPlayList> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  int _selectedValueOrder = 0;
  int _selectedValueSort = 0;
  Set<SongModel> selectedSongs = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: MyTheme().secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () async {
              final playlistBox = await Hive.openBox<Playlist>('playlists');
              final playlistName = widget.ListName;

              final existingPlaylist = playlistBox.get(playlistName);

              if (existingPlaylist != null) {
                final updatedPlaylist = Playlist(
                  name: playlistName,
                  song: [...existingPlaylist.song, ...selectedSongs.map((song) => Song.fromSongModel(song))],
                );
                playlistBox.put(playlistName, updatedPlaylist);
              } else {
                final newPlaylist = Playlist(
                  name: playlistName,
                  song: selectedSongs.map((song) => Song.fromSongModel(song)).toList(),
                );
                playlistBox.put(playlistName, newPlaylist);
              }

              await playlistBox.close();
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: OnAudioQuery().querySongs(
          sortType: sortTechnique[_selectedValueSort],
          orderType: orderTechnique[_selectedValueOrder],
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<SongModel> songs = snapshot.data!;
            return SongPlayListView(
              songs: songs,
              onSongSelected: (index) {
                setState(() {
                  final selectedSong = songs[index];
                  if (selectedSongs.contains(selectedSong)) {
                    selectedSongs.remove(selectedSong);
                  } else {
                    selectedSongs.add(selectedSong);
                  }
                });
              },
            );
          }
        },
      ),
    );
  }
}
