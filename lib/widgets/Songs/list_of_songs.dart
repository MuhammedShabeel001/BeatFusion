import 'package:beatfusion/widgets/Songs/song_list_view.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {

  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      
        body: FutureBuilder<List<SongModel>>(
          future: OnAudioQuery().querySongs(
            uriType: UriType.EXTERNAL,
            ignoreCase: true
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List<SongModel> songs = snapshot.data!;
            return SongListView(songs: songs);
          }
        },
      )
    );
  }
}