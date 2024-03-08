import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/widgets/Library/playlist/list_of_playlist_songs.dart';
import 'package:beatfusion/widgets/Library/playlist/playlist_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class SongsPlayList extends StatefulWidget {
  final Function? onPlaylistAdded; 
  final VoidCallback? onPlaylistUpdated;
  // ignore: non_constant_identifier_names
  String ListName;
  // ignore: non_constant_identifier_names
  SongsPlayList({Key? key, required this.ListName, this.onPlaylistAdded, this.onPlaylistUpdated}) : super(key: key);

  @override
  State<SongsPlayList> createState() => _SongsPlayListState();
}

class _SongsPlayListState extends State<SongsPlayList> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  Set<SongModel> selectedSongs = {};

  void addToPlaylistFunction() async {
    final playlistBox = await Hive.openBox<Playlist>('playlists');
    final playlistName = widget.ListName;
    final existingPlaylist = playlistBox.get(playlistName);
    final Set<int> existingSongKeys = existingPlaylist?.song.map((song) => song.key).toSet() ?? {};
    final List<SongModel> uniqueSelectedSongs = selectedSongs.where((song) => !existingSongKeys.contains(song.id)).toList();

    for (var song in uniqueSelectedSongs) {
      if (existingPlaylist != null) {
        final isDuplicate = existingPlaylist.song.any((existingSong) => existingSong.key == song.id);
        if (!isDuplicate) {
          existingPlaylist.song.add(Song.fromSongModel(song));
        }
      } else {
        final newPlaylist = Playlist(
          name: playlistName,
          song: selectedSongs.map((song) => Song.fromSongModel(song)).toList(),
        );
        playlistBox.put(playlistName, newPlaylist);
      }
    }

    await playlistBox.close();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PlaylistScreen()));
    if (widget.onPlaylistAdded != null) {
      widget.onPlaylistAdded!();
    }
    if (widget.onPlaylistUpdated != null) {
      widget.onPlaylistUpdated!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(    
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: SvgPicture.asset('assets/pics/back.svg')),
          backgroundColor: MyTheme().secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0.0,
          actions: [
            TextButton(
              onPressed: () async {
              addToPlaylistFunction();
              },
                child: Text('OK',style: FontStyles.greeting,),
            )
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
          future: OnAudioQuery().querySongs(
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

