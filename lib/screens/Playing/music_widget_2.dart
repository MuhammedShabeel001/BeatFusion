// import 'package:beatfusion/common/text_style.dart';
// import 'package:beatfusion/common/theme.dart';
// import 'package:beatfusion/database/favorite.dart';
// import 'package:beatfusion/database/song.dart';
// import 'package:beatfusion/functions/controller.dart';
// import 'package:beatfusion/screens/Playing/playing_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:just_audio/just_audio.dart';

// class MusicPlayerWidget extends StatefulWidget {
//   Song songdata;
//   AudioPlayer audioPlayer;
//   MusicPlayerWidget({required this.songdata, required this.audioPlayer});

//   @override
//   State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
// }

// class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
//   late  AudioPlayer _audioPlayer;
//   double _currentSliderValue = 0.0;
//   bool isPlaying = false;
//   bool isRepeating = false;

//   void toggleFavorite(Song song) async {
//     var favoriteBox = await Hive.openBox<SongFavorite>('FavouriteSong');
//     var currentSong = song;
//     bool isFavorite = favoriteBox.get(0)?.song.any((s) => s.filePath == currentSong.filePath) ?? false;
//     if (isFavorite) {
//       var favoriteSongs = favoriteBox.get(0)?.song ?? [];
//       favoriteSongs.removeWhere((s) => s.filePath == currentSong.filePath);
//       favoriteBox.put(0, SongFavorite(song: favoriteSongs));
//       showSnackbar('Removed from Favorites');
//     } else {
//       var favoriteSongs = favoriteBox.get(0)?.song ?? [];
//       favoriteSongs.add(currentSong);
//       favoriteBox.put(0, SongFavorite(song: favoriteSongs));
//       showSnackbar('Added to Favorites');
//     }
//   setState(() {});
// }

// void toggleRepeat() async {
//   setState(() {
//     isRepeating = !isRepeating;
//   });
//   if (isPlaying) {
//     if (isRepeating) {
//       await _audioPlayer.play();
//     }
//   }
//   // ignore: use_build_context_synchronously
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         isRepeating ? 'Repeat On' : 'Repeat Off',
//         textAlign: TextAlign.center,
//         style: FontStyles.artist2,
//       ),
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.only(
//         bottom: 310,
//         left: 70,
//         right: 70,
//       ),
//       duration: const Duration(milliseconds: 600),
//       backgroundColor: const Color.fromARGB(131, 64, 66, 88),
//       elevation: 0,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//       ),
//     ),
//   );
// }

//   void playNext() async {
//     int currentIndex = findcurrentSongIndex(widget.songdata);
//     var songsList = getSongBoxAsList();
//     if (currentIndex != -1 && currentIndex < songsList.length - 1) {
//       setState(() {
//         widget.songdata = songsList[currentIndex + 1];
//       });
//       await _audioPlayer.setUrl(widget.songdata.filePath);
//       await _audioPlayer.play();
//       addToHistory(widget.songdata);
//     }
//   }

//   void playPrev() async {
//     int currentIndex = findcurrentSongIndex(widget.songdata);
//     var songsList = getSongBoxAsList();
//     if (currentIndex != -1 && currentIndex > 0) {
//       setState(() {
//         widget.songdata = songsList[currentIndex - 1];
//       });
//       await _audioPlayer.setUrl(widget.songdata.filePath);
//       await _audioPlayer.play();
//       addToHistory(widget.songdata);
//     }
//   }

//   void stopSong() async {
//     await _audioPlayer.stop();
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   @override
  
//     _audioPlayer = widget.audioPlayer;
   
//   Widget build(BuildContext context) {

//      var playBox = Hive.box<Song>('songsbox');
//     int findCurrentSongIndex(String filePath) {
//       for (int i = 0; i < playBox.length; i++) {
//         if (playBox.getAt(i)?.filePath == filePath) {
//           return i;
//         }
//       }
//       return -1;
//     }

//     return Container(
//       padding: EdgeInsets.all(10),
//       // height: double.infinity,
//       decoration: BoxDecoration(
//         color: MyTheme().secondaryColor,
//         borderRadius: BorderRadius.circular(12)
//       ),
//       child: Column(
//         children: [
//           Text(
//             widget.songdata.name,
//             style: FontStyles.name2,
//             maxLines: 1,
//             textAlign: TextAlign.center,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(height: 5,),
//           Text(
//             widget.songdata.artist,
//             style: FontStyles.artist2,
//             maxLines: 1,
//             textAlign: TextAlign.center,
//             overflow: TextOverflow.ellipsis,            
//           ),
//           Slider(
//             value: _currentSliderValue.clamp(0.0,_audioPlayer.duration?.inMilliseconds.toDouble()??0.0),
//             min: 0.0,
//             max: _audioPlayer.duration?.inMilliseconds.toDouble()??0, 
//             onChanged: (double value) {
//               setState(() {
//                 _currentSliderValue = value;
//               });
//             },
//             onChangeEnd: (double value) {
//               _audioPlayer.seek(
//                 Duration(milliseconds: value.toInt()),
//               );
//             },
//             activeColor: Colors.black,
//             inactiveColor: Colors.grey.shade500,
//             ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 formatDuration(Duration(milliseconds: _currentSliderValue.toInt())),
//                 style: TextStyle(color: Colors.grey.shade500),
//               ),
//               Text(
//                 formatDuration(_audioPlayer.duration??Duration.zero),
//                 style: TextStyle(color: Colors.grey.shade500),
//               ),
//             ],
//           ),
//           SizedBox(height: 5,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () async {
//                                         final currentposition = _audioPlayer.position;
//                                         const tenSec = Duration(seconds: 10);
//                                         if(currentposition >= tenSec){
//                                           await _audioPlayer.seek(Duration.zero);
//                                           await _audioPlayer.play();
//                                         }else{
//                                           stopSong();
//                                         }
//                                         int currentIndex = findCurrentSongIndex(widget.songdata.filePath);
//                                         if (currentIndex != -1 && currentIndex > 0){
//                                           playPrev();
//                                         AudioPlayer();
//                                       }
//                                     }, 
//                 icon:SvgPicture.asset('assets/pics/prev.svg')),
//                 SizedBox(width: 30,),
//                 Container(
//                                       height: 60,
//                                       width: 60,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: MyTheme().tertiaryColor
//                                       ),
//                                       child: isPlaying
//                                         ? IconButton(
//                                             onPressed: () async {
//                                               setState(() {
//                                                 isPlaying = !isPlaying;
//                                               });
//                                             await _audioPlayer.pause();
//                                             },
//                                             icon: SvgPicture.asset('assets/pics/pauseblack.svg'),
//                                           )
//                                         : IconButton(
//                                             onPressed: () async {
//                                               setState(() {
//                                                 isPlaying = !isPlaying;
//                                               });
//                                               await _audioPlayer.play();
//                                             },
//                                             icon: SvgPicture.asset('assets/pics/playblack.svg')),
//                                       ),
//               SizedBox(width: 30,),
//               IconButton(
//                                       onPressed: ()  {
//                                         int currentIndex = findCurrentSongIndex(widget.songdata.filePath);
//                                         if (currentIndex != -1 && currentIndex < playBox.length-1){
//                                           playNext();
//                                         }
//                                       },
//                                         icon: SvgPicture.asset('assets/pics/next.svg')),
//                SizedBox(height: 50,),
//                SizedBox(
//                                   height: 50,
//                                   width: double.infinity,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () async {
//                                             toggleFavorite(widget.songdata);
//                                           }, 
//                                             icon: Icon(
//                                               favoriteBoxContainsSong(widget.songdata)
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_border    ,
//                                                 color: favoriteBoxContainsSong(widget.songdata)
//                                                 ? Colors.red
//                                                 : MyTheme().iconColor
//                                           )
                                          
//                                           ),
//                                         IconButton(
//                                           splashColor: Colors.transparent,
//                                           highlightColor: Colors.transparent,
//                                           onPressed: () async {
//                                             toggleRepeat();
//                                             },
//                                             icon:isRepeating
//                                             ? SvgPicture.asset('assets/pics/repeat on.svg')
//                                             : SvgPicture.asset('assets/pics/repeate off.svg')),
//                                         IconButton(
//                                           onPressed: () => playlistBottom(context,widget.songdata), 
//                                             icon: SvgPicture.asset('assets/pics/add list.svg')),                         
//                               ],
//                             ),
//                           )                         
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }