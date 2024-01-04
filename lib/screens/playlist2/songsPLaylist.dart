import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/playlist2/listOfPLaylistSongs.dart';
import 'package:beatfusion/widgets/song_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsPlayList extends StatefulWidget {
  const SongsPlayList({super.key});

  @override
  State<SongsPlayList> createState() => _SongsPlayListState();
}

class _SongsPlayListState extends State<SongsPlayList> {

  

  final OnAudioQuery audioQuery = OnAudioQuery();
  int _selectedValueOrder = 0;
  int _selectedValueSort = 0;





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: MyTheme().secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 0.0,
        actions: [
          TextButton(onPressed: (){}, child: Text('OK'))
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: OnAudioQuery().querySongs(
          sortType: sortTechnique[_selectedValueSort],
          orderType: orderTechnique[_selectedValueOrder],
          uriType: UriType.EXTERNAL,
          ignoreCase: true
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<SongModel> songs = snapshot.data!;
            return SongPlayListView(songs: songs);
          }
        },
      )
    );
  }
}