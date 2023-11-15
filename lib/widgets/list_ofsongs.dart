import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({super.key});

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final AudioPlayer _player = AudioPlayer();

  int _selectedValueSort = 0;

  int _selectedValueOrder = 0;

  int currentSongID = 0;

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

   void _updateSongDetails(int index){
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentIndex = index;
        currrentSongID = songs[index].id;
        isPlaying = true;
      }
    });
  }


  void _changePlayerVisibility() {
    setState(() {
      isPlayerViewVisible = true;
    });
  }

  late Widget permissionResult;
  defaultSongs(defaultsong) {
    setState(() {
      search = defaultsong.data!;
    });
  }

    bool isHome = true;
  // bool isQueue = false;
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    
    return Container(
        decoration: const BoxDecoration(
        ),
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: sortTechnique[_selectedValueSort],
              orderType: orderTechnique[_selectedValueOrder],
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),

            //Builder for future widget
            builder: (context, item) {
              //if the directory still retrieving mp3 files
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //Builds the list of song retrieved
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: MyTheme().secondaryColor ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    pinned: true,
                    elevation: 0,

                    //Create Screen to make a Search Page
                    actions: [
                      IconButton(
                          onPressed: () => changeOrder(),
                          icon: SvgPicture.asset('assets/pics/order.svg'),),
                      IconButton(
                          onPressed: () => sortSongs(),
                          icon: SvgPicture.asset('assets/pics/sort.svg'),),
                    ],
                  ),
                  item.data!.isNotEmpty
                      ? SliverList(
                         
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            //Return the tile of every song
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              
                              child: ListTile(
                                

                                title: SizedBox(
                                  height: 18,
                                  child: Text(
                                    (item.data![index].title)
                                        .replaceAll('_', ' '),
                                    style: currentSongID !=
                                            item.data![index].id
                                            ?FontStyles.name
                                            :FontStyles.selectedName,
                                    maxLines: 1,
                                  ),
                                ),

                                subtitle: Text(
                                  item.data![index].artist ?? "No Artist",
                                  style: FontStyles.artist,
                                  maxLines: 1,
                                ),

                                trailing: IconButton(
                                  onPressed: (){}, 
                                  icon: Icon(Icons.more_vert,
                                  color: MyTheme().iconColor,)),

                                //Retrieve the song illustration
                                leading: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9)
                                  ),
                                  child: QueryArtworkWidget(
                                    id: item.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder: BorderRadius.circular(9),
                                    keepOldArtwork: true,
                                
                                    //If the artwork or the song has no illustration
                                    nullArtworkWidget: Container(
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(9),
                                          color: MyTheme()
                                              .primaryColor,
                                        ),
                                        child: const Icon(
                                          Icons.music_note_sharp,
                                          color: Color.fromRGBO(189, 189, 189, 1),
                                        )),
                                  ),
                                ),

                                onTap: () async {
                                  if (currentSongID != item.data![index].id) {
                                    //Store the full list of songs
                                    songs = item.data!;
                                    _changePlayerVisibility();
                                    // Play a sound as a one-shot, releasing its resources when it finishes playing.

                                    _updateSongDetails(index);
                                    Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                        builder: (context) => const ScreenHome(),));

                                    _player.setAudioSource(
                                        createPlaylist(item.data),
                                        initialIndex: index);
                                    _player.play();
                                  } else {
                                    setState(() {
                                      isMusicPlayerTapped =
                                          !isMusicPlayerTapped;
                                    });
                                  }
                                },
                              ),
                            );
                          }, childCount: item.data!.length),
                          
                        )
                      : SliverToBoxAdapter(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Center(child: permissionResult)),
                        ),
                ],
              );
            }),
      );
  }
}