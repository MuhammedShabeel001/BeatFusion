import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/widgets/Songs/song_list_view.dart';
// import 'package:beatfusion/widgets/song_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsList extends StatefulWidget {
  const SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {

  final OnAudioQuery audioQuery = OnAudioQuery();
  int _selectedValueOrder = 0;
  int _selectedValueSort = 0;

 

 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      
      body: FutureBuilder<List<SongModel>>(
        future: OnAudioQuery().querySongs(
          sortType: sortTechnique[_selectedValueSort],
          orderType: orderTechnique[_selectedValueOrder],
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