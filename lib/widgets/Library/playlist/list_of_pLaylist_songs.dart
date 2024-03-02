import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/widgets/Library/playlist/playlist_music.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPlayListView extends StatefulWidget {
  final List<SongModel> songs;
  final void Function(int index) onSongSelected;

  // ignore: use_key_in_widget_constructors
  const SongPlayListView({Key? key, required this.songs, required this.onSongSelected});

  @override
  State<SongPlayListView> createState() => _SongPlayListViewState();
}

class _SongPlayListViewState extends State<SongPlayListView> {
  int currentSongID = 0;
  late Box<Song> boxsong;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    openSongs();
  }

  void addToPlaylistFunction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaylistScreen()));
  }

  void openSongs() async {
    boxsong = await Hive.openBox<Song>('songbox');
  }

  void _changePlayerVisibility() {
    setState(() {
      isPlayerViewVisible = true;
    });
  }

  void _updateSongDetails(int index) {
    setState(() {
      if (widget.songs.isNotEmpty) {
        currentSongTitle = widget.songs[index].title;
        currentIndex = index;
        currentSongID = widget.songs[index].id;
        currentArtist = widget.songs[index].artist;
        isPlaying = true;
      }
    });
  }

  // ignore: prefer_collection_literals
  Set<int> selectedSongs = Set<int>();

  @override
  Widget build(BuildContext context) {
    final songBox = Hive.box<Song>('songsbox');

    for (var song in widget.songs) {
      if (songBox.get(song.id) == null) {
        songBox.put(song.data, Song(
          key: song.id,
          name: song.title,
          artist: song.artist ?? 'unknown',
          duration: song.duration ?? 0,
          filePath: song.data,
        ));
      }
    }

    return ListView.builder(
      itemCount: songBox.length,
      itemBuilder: (context, index) {
        final song = songBox.getAt(index);
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            title: SizedBox(
              height: 18,
                child: Text(
                  song!.name,
                  style: FontStyles.name,
                  maxLines: 1,
                ),
            ),
            subtitle: Text(
              song.artist,
              style: FontStyles.artist,
              maxLines: 1,
            ),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: MyTheme().primaryColor,
              ),
                child: const Icon(
                  Icons.music_note_rounded,
                  color: Colors.white,
              ),
            ),
            trailing: Checkbox(
              value: selectedSongs.contains(index),
              onChanged: (bool? value) {
                widget.onSongSelected(index);
                setState(() {
                  if (value != null) {
                    if (value) {
                      selectedSongs.add(index);
                    } else {
                      selectedSongs.remove(index);
                    }
                  }
                });
              },
            ),
            onTap: () async {
              _updateSongDetails(index);
              _changePlayerVisibility();
          },
        );
      },
    );
  }
}