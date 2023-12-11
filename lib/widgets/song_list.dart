// import 'package:beatfusion/common/text_style.dart';
// import 'package:beatfusion/common/theme.dart';
// import 'package:beatfusion/functions/control_functions.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:rxdart/rxdart.dart';

// class SongList extends StatefulWidget {
//   const SongList({super.key});

//   @override
//   State<SongList> createState() => _SongListState();
// }

// class _SongListState extends State<SongList> {

//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   final AudioPlayer _player = AudioPlayer();

//   int _selectedValueSort = 0;

//   int _selectedValueOrder = 0;

//   late Widget permissionResult;

//   bool isHome = true;
//  bool isQueue = true;
//  bool isSearch = false;

//   void _changePlayerVisibility() {
//     setState(() {
//       isPlayerViewVisible = true;
//     });
//   }

//   Stream<DurationState> get _durationStateStream =>
//     Rx.combineLatest2<Duration, Duration?, DurationState>(
//       _player.positionStream,
//       _player.durationStream,
//       (position,duration) => DurationState(
//         position: position, total: duration ?? Duration.zero
//       )
//     );

//   requestStoragePermission() async{
//     if(!kIsWeb){
//       bool permissionStatus = await _audioQuery.permissionsStatus();

//       setState(() {
//         permissionResult =const Center(
//           child: CircularProgressIndicator(),
//         );
//       });

//       if(!permissionStatus){
//         setState(() {
//           permissionResult = Column(
//             children: [
//               Text(
//                 'Access Denied External Storage',
//                 style: FontStyles.text,
//               ),
//               TextButton(
//                 onPressed: ()async{
//                   await _audioQuery.permissionsRequest();
//                   requestStoragePermission();
//                 },
//                 style: TextButton.styleFrom(
//                   backgroundColor: MyTheme().buttonColor
//                 ),
//                  child: Text(
//                   'Request Access',
//                   style: FontStyles.text,
//                  ))
//             ],
//           );
//         });
//       }
//     }
//   }

//   defaultSongs(defaultsong){
//     setState(() {
//       search = defaultsong.data!;
//     });
//   }

//   changeOrder(){
//     Theme(
//       data: Theme.of(context).copyWith(
//         popupMenuTheme: PopupMenuThemeData(
//           color: const Color.fromRGBO(180, 197, 228, 0.4),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         )
//       ),
//       child: PopupMenuButton(
//         // icon: SvgPicture.asset('assets/pics/Property 1.svg'),
//         offset: Offset(0, 45),
//         itemBuilder: (context) => <PopupMenuEntry>[
//           PopupMenuItem(
//             child: RadioListTile(
//               activeColor: MyTheme().primaryColor,
//               value: 0, 
//               groupValue: _selectedValueOrder, 
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValueOrder = value!;
//                   Navigator.pop(context);
//                 });
//               },
//               title: Text(
//                 'Ascending',
//               style: FontStyles.text,
//               ),)),
//               PopupMenuItem(
//             child: RadioListTile(
//               activeColor: MyTheme().primaryColor,
//               value: 1, 
//               groupValue: _selectedValueOrder, 
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValueOrder = value!;
//                   Navigator.pop(context);
//                 });
//               },
//               title: Text(
//                 'Descending',
//               style: FontStyles.text,
//               ),)),
//         ],),
//     );
//   }

//   sortSongs(){
//     Theme(
//       data: Theme.of(context).copyWith(
//         popupMenuTheme: PopupMenuThemeData(
//           color: const Color.fromRGBO(180, 197, 228, 0.4),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         )
//       ),
//       child: PopupMenuButton(
//         // icon: SvgPicture.asset('assets/pics/Property 1.svg'),
//         // offset: Offset(0, 45),
//         itemBuilder: (context) => <PopupMenuEntry>[
//           PopupMenuItem(
//             child: RadioListTile(
//               activeColor: MyTheme().primaryColor,
//               value: 0, 
//               groupValue: _selectedValueSort, 
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValueSort = value!;
//                   Navigator.pop(context);
//                 });
//               },
//               title: Text(
//                 'Sort Alphabetically',
//               style: FontStyles.text,
//               ),)),
//               PopupMenuItem(
//             child: RadioListTile(
//               activeColor: MyTheme().primaryColor,
//               value: 1, 
//               groupValue: _selectedValueSort, 
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValueSort = value!;
//                   Navigator.pop(context);
//                 });
//               },
//               title: Text(
//                 'Sort by Artist',
//               style: FontStyles.text,
//               ),)),
//               PopupMenuItem(
//             child: RadioListTile(
//               activeColor: MyTheme().primaryColor,
//               value: 2, 
//               groupValue: _selectedValueSort, 
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValueSort = value!;
//                   Navigator.pop(context);
//                 });
//               },
//               title: Text(
//                 'Sort by Date',
//               style: FontStyles.text,
//               ),)),
//               PopupMenuItem(
//             child: RadioListTile(
//               activeColor: MyTheme().primaryColor,
//               value: 3, 
//               groupValue: _selectedValueSort, 
//               onChanged: (value) {
//                 setState(() {
//                   _selectedValueSort = value!;
//                   Navigator.pop(context);
//                 });
//               },
//               title: Text(
//                 'Sort by Album',
//               style: FontStyles.text,
//               ),)),
//         ],),
//     );
//   }

//   void _updateSongDetails(int index){
//     setState(() {
//       if (songs.isNotEmpty) {
//         currentSongTitle = songs[index].title;
//         currentIndex = index;
//         currrentSongID = songs[index].id;
//         isPlaying = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget child;

//     if (isHome) {
//       child = Container(
//         height: double.infinity,
//         child: FutureBuilder<List<SongModel>>(
//           future: _audioQuery.querySongs(
//             sortType: sortTechnique[_selectedValueSort],
//             orderType: orderTechnique[_selectedValueOrder],
//             uriType: UriType.EXTERNAL,
//             ignoreCase: true,
//           ), 
//           builder: (context, item ) {
//             if (item.data == null) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             return CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//   pinned: true,
//   elevation: 0,
//   actions: [
//     Container(
//       height: 50,
//       width: 50,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: MyTheme().tertiaryColor,
//           style: BorderStyle.solid,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(7)
//       ),
//       child: IconButton(
//         onPressed: () => changeOrder(), 
//         icon: SvgPicture.asset('assets/pics/order.svg'),),
//     ),
//     Container(
//       height: 50,
//       width: 50,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: MyTheme().tertiaryColor,
//           style: BorderStyle.solid,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(7)
//       ),
//       child: IconButton(
//         onPressed: () => sortSongs(), 
//         icon: SvgPicture.asset('assets/pics/Property 1.svg'),),
//     ),
//   ],
// ),
// item.data!.isEmpty ?
//             SliverList(
//               delegate: SliverChildBuilderDelegate((context, index){
//                 return SizedBox(
//                   height: double.infinity,
//                   width: double.infinity,
//                   child: ListTile(
//                     trailing: IconButton(
//                       onPressed: (){}, 
//                       icon: SvgPicture.asset('assets/pics/more.svg')),
//                     title: Text(
//                       (item.data![index].title)
//                       .replaceAll('_', ' '),
//                     style: TextStyle(
//                       color:  currrentSongID !=
//                                   item.data![index].id 
//                                   ? MyTheme().tertiaryColor
//                                   : MyTheme().selectedTile
//                     ),
//                     maxLines: 1,),
//                     subtitle: Text(
//                       item.data![index].artist ?? 'No Artist',
//                       style: FontStyles.artist,
//                       maxLines: 1,
//                     ),

//                     leading: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(9),
//                         color: Color.fromARGB(255, 206, 206, 206),
//                       ),
//                       height: 50,
//                       width: 50,
//                       child: QueryArtworkWidget(
//                         id: item.data![index].id, 
//                         type: ArtworkType.AUDIO,
//                         artworkBorder: BorderRadius.circular(9),
//                         keepOldArtwork: true,
                        
//                         nullArtworkWidget: Icon(Icons.music_note_rounded),),

                        
//                     ),
//                     onTap: () async{
//                       if (currrentSongID != item.data![index].id) {
//                         songs = item.data!;
//                         _changePlayerVisibility();

//                         _updateSongDetails(index);

//                         _player.setAudioSource(
//                           createPlaylist(item.data),
//                           initialIndex: index
//                         );
//                         _player.play();
//                       }else{
//                         setState(() {
//                           isMusicPlayerTapped = !isMusicPlayerTapped;
//                         });
//                       }
//                     },
//                   ),
                  
//                 );
//               }))
//               :SliverToBoxAdapter(
//                 child: Center(child: permissionResult,),
//               )
//               ],
//             );
            
//           },),
//       );
//     }else{
//       Container();
//     }
//    return Expanded(
//     child: Container(
      
//     )) ;
//   }
// }