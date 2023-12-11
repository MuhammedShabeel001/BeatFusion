// import 'package:beatfusion/database/functions/song_function.dart';
import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
// import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/widgets/song_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
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



  changeOrder() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  color: MyTheme().primaryColor),
              child: Stack(children: [
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
                    RadioListTile(
                      activeColor: MyTheme().selectedTile,
                      value: 0,
                      groupValue: _selectedValueOrder,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueOrder = value!;
                          Navigator.pop(context);
                        });
                      },
                      title: Text(
                        'Ascending',
                        style:
                            FontStyles.order,
                      ),
                    ),
                    RadioListTile(
                      
                      activeColor: MyTheme().selectedTile,
                      value: 1,
                      groupValue: _selectedValueOrder,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueOrder = value!;
                          Navigator.pop(context);
                        });
                      },
                      title: Text(
                        'Descending',
                        style:
                            FontStyles.order,
                      ),
                    ),
                  ],
                )
              ]));
        });
  }

  sortSongs() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30.0)),
                  color: MyTheme().primaryColor),
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
                      RadioListTile(
                        activeColor: MyTheme().selectedTile,
                        value: 0,
                        groupValue: _selectedValueSort,
                        onChanged: (value) {
                          setState(() {
                            _selectedValueSort = value!;
                            Navigator.pop(context);
                          });
                        },
                        title: Text(
                          'Sort Alphabetically',
                          style:
                              FontStyles.order,
                        ),
                      ),
                      RadioListTile(
                        activeColor: MyTheme().selectedTile,
                        value: 1,
                        groupValue: _selectedValueSort,
                        onChanged: (value) {
                          setState(() {
                            _selectedValueSort = value!;
                            Navigator.pop(context);
                          });
                        },
                        title: Text(
                          'Sort by Artist',
                          style:
                              FontStyles.order,
                        ),
                      ),
                      RadioListTile(
                        activeColor: MyTheme().selectedTile,
                        value: 2,
                        groupValue: _selectedValueSort,
                        onChanged: (value) {
                          setState(() {
                            _selectedValueSort = value!;
                            Navigator.pop(context);
                          });
                        },
                        title: Text(
                          'Sort by Date',
                          style:
                              FontStyles.order,
                        ),
                      ),
                      RadioListTile(
                        activeColor: MyTheme().selectedTile,
                        value: 3,
                        groupValue: _selectedValueSort,
                        onChanged: (value) {
                          setState(() {
                            _selectedValueSort = value!;
                            Navigator.pop(context);
                          });
                        },
                        title: Text(
                          'Sort by Album',
                          style:
                              FontStyles.order,
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        });
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: MyTheme().secondaryColor,
        // shadowColor: MyTheme().secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => changeOrder(), 
            icon: SvgPicture.asset('assets/pics/order.svg'),),
          IconButton(
            onPressed: () => sortSongs(),
            icon: SvgPicture.asset('assets/pics/sort.svg'),)
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
            return SongListView(songs: songs);
          }
        },
      )
    );
      
    
  }
}