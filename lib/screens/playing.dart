import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/widgets/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class PlayingScreen extends StatefulWidget {
  Song songdata;
  AudioPlayer audioPlayer;

  PlayingScreen({Key? key,  required this.songdata, required this.audioPlayer})
      : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  late  AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double _currentSliderValue = 0.0;
  bool isRepeating = false;
  

  String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

  @override
  void initState(){
    super.initState();
    _audioPlayer = widget.audioPlayer;

    try{
      _audioPlayer.setUrl(widget.songdata.filePath);
      _audioPlayer.play();

      addToHistory(widget.songdata);
      setState(() {
        isPlaying = true;
      });

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _currentSliderValue = position.inMilliseconds.toDouble();
        });

        // if (position >= _audioPlayer.position) {
        //   playNext();
        // }
      });

      
      
    }catch(e){
      print('catch an error');
    }
  }

  void toggleRepeat(){
    setState(() {
      isRepeating = !isRepeating;
      _audioPlayer.setLoopMode(isRepeating ? LoopMode.one : LoopMode.off);
    });
  }

  List<Song> getSongBoxAsList(){
    var songBox = Hive.box<Song>('songsbox');
    List<Song> songsList = [];
    for (int i=0; i<songBox.length; i++){
      songsList.add(songBox.getAt(i)!);
    }
    return songsList;
  }

  void playNext() async {
    
    int currentIndex = findcurrentSongIndex(widget.songdata);
    var songsList = getSongBoxAsList();

    if (currentIndex != -1 && currentIndex < songsList.length - 1) {
      setState(() {
        widget.songdata = songsList[currentIndex + 1];
      });
      await _audioPlayer.setUrl(widget.songdata.filePath);
      await _audioPlayer.play();

      addToHistory(widget.songdata);
    }
  }

  void playPrev() async {
    
    int currentIndex = findcurrentSongIndex(widget.songdata);
    var songsList = getSongBoxAsList();

    if (currentIndex != -1 && currentIndex > 0) {
      setState(() {
        widget.songdata = songsList[currentIndex - 1];
      });
      await _audioPlayer.setUrl(widget.songdata.filePath);
      await _audioPlayer.play();

      addToHistory(widget.songdata);
    }
  }

  int findcurrentSongIndex(Song song) {
    var songsList = getSongBoxAsList();
    for (int i = 0; i < songsList.length; i++) {
      if (songsList[i].filePath == song.filePath) {
        return i;
      }
    }
    return -1;
  }

  // int findcurrentSong(Song song){
  //   var songsbox = Hive.box<Song>('songbox');
  //   for(int i=0; i<songsbox.length; i++){
  //     if (songsbox.getAt(i)?.name == song.name || songsbox.getAt(i)?.filePath == song.filePath){
  //       return i;
  //     }
  //   }
  //   return -1;
  // }

  void togglePlayPause() async {
    if(isPlaying){
      await _audioPlayer.pause();
    }else{
      await _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void stopSong() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
  showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            backgroundColor: MyTheme().secondaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 10,
              child: StreamBuilder<double>(
                stream: stream,
                builder: (context, snapshot) {
                  return Slider(
                    min: min,
                    max: max,
                    divisions: divisions,
                    value: snapshot.hasData ? snapshot.data! : value,
                    onChanged: onChanged,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var PlayBox = Hive.box<Song>('songsbox');

    // int findcurrentSong(songs){
    //   for (int i=0; i< PlayBox.length; i++){
    //     if(PlayBox.getAt(i)?.filePath == songs){
    //       return i;
    //     }
    //   }
    //   return -1;
    // }

    int findCurrentSongIndex(String filePath) {
      for (int i = 0; i < PlayBox.length; i++) {
        if (PlayBox.getAt(i)?.filePath == filePath) {
          return i;
        }
      }
      return -1;
    }
    
    
    // void playNext(int index)async{
    //   final nextSong = PlayBox.getAt(index);
    //   if (nextSong != null ){
    //     setState(() {
    //       widget.songdata = nextSong;
    //     });
    //     await _audioPlayer;
    //   }
    // }

    // void playPrev(int index)async{
    //   final prevSong = PlayBox.getAt(index);
    //   if (prevSong != null ){
    //     setState(() {
    //       widget.songdata = prevSong;
    //     });
    //     await _audioPlayer;
    //   }
    // }

    // final songBox = Hive.box<Song>('songsbox');

    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: SvgPicture.asset('assets/pics/back.svg'),
          ),
          actions: [
            IconButton(
              onPressed: (){
                showSliderDialog(
                  context: context, 
                  title: 'Volume', 
                  divisions: 20, 
                  min: 0.0, 
                  max: 1.0, 
                  value: _audioPlayer.volume, 
                  stream: _audioPlayer.volumeStream, 
                  onChanged: _audioPlayer.setVolume);
              }, 
              icon: const Icon(Icons.volume_up))
          ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: MyTheme().primaryColor,
        child: Expanded(
          child: Column(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyTheme().secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(
                          color: MyTheme().primaryColor,
                          blurRadius: 4,
                          offset: const Offset(0, 4)
                         )]
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: MyTheme().primaryColor,
                        borderRadius: BorderRadius.circular(9),
                       boxShadow: [BoxShadow(
                        color: MyTheme().primaryColor,
                        blurRadius: 4,
                        offset: const Offset(0, 4)
                       )]
                      ),
                      child: const Icon(Icons.music_note_rounded,
                      color: Colors.white,
                      size: 150,),
                    ),
                )),
                const SizedBox(height: 10,),
              Flexible(
                flex: 5,
                child: Container(padding: const EdgeInsets.all(10),
                height: double.infinity,
                width: double.infinity,
                   decoration: BoxDecoration(
                    color: MyTheme().secondaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                      children: [
                        Text(
                          widget.songdata.name,
                          style: FontStyles.name2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.songdata.artist,
                          style: FontStyles.artist2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Slider(
                          value: _currentSliderValue.clamp(0.0, _audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0),
                          min: 0.0,
                          max: _audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0,
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                          onChangeEnd: (double value) {
                            _audioPlayer.seek(
                              Duration(milliseconds: value.toInt()),
                            );
                          },
                          activeColor: const Color.fromARGB(255, 54, 136, 244),
                          inactiveColor: Colors.grey.shade500,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDuration(Duration(milliseconds: _currentSliderValue.toInt())),
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            Text(
                              formatDuration(_audioPlayer.duration ?? Duration.zero),
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final currentposition = _audioPlayer.position;
                                    const tenSec = Duration(seconds: 10);

                                    if(currentposition >= tenSec){
                                      await _audioPlayer.seek(Duration.zero);
                                      await _audioPlayer.play();
                                    }else{
                                      stopSong();
                                    }
                                    int currentIndex = findCurrentSongIndex(widget.songdata.filePath);
                                    if (currentIndex != -1 && currentIndex > 0){
                                      playPrev();
                                      await AudioPlayer();
                                    }
                            //         _audioPlayer.previousIndex;
                            //         int newPosition =
                            //     (_audioPlayer.position.inSeconds - 10).toInt();
                            // if (newPosition <
                            //     _audioPlayer.duration!.inSeconds) {
                            //   _audioPlayer.seek(Duration(seconds: newPosition));
                            //   setState(() {
                            //     _currentSliderValue = newPosition.toDouble();
                            //   });}
                                  },
                                  icon: SvgPicture.asset('assets/pics/prev.svg')),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: MyTheme().tertiaryColor
                                ),
                                child: isPlaying
                                    ? IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            isPlaying = !isPlaying;
                                          });
                                          await _audioPlayer.pause();
                                        },
                                        icon: SvgPicture.asset('assets/pics/pauseblack.svg'),
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            isPlaying = !isPlaying;
                                          });
                                          await _audioPlayer.play();
                                        },
                                        icon: SvgPicture.asset('assets/pics/playblack.svg')),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                  onPressed: ()  {
                                    int currentIndex = findCurrentSongIndex(widget.songdata.filePath);
                                    if (currentIndex != -1 && currentIndex < PlayBox.length-1){
                                      playNext();
                                    }
                            //         int newPosition =
                            //     (_audioPlayer.position.inSeconds + 10).toInt();
                            // if (newPosition <
                            //     _audioPlayer.duration!.inSeconds) {
                            //   _audioPlayer.seek(Duration(seconds: newPosition));
                            //   setState(() {
                            //     _currentSliderValue = newPosition.toDouble();
                            //   });}
                                  },
                                  icon: SvgPicture.asset('assets/pics/next.svg')),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    //favorite
                                    IconButton(
  onPressed: () async {
    var FavoriteBox = await Hive.openBox<SongFavorite>('song_favorite_box');
    var currentSong = widget.songdata;
    var FavSongs = FavoriteBox.get(0)?.song ?? [];

    FavSongs.add(Song(
      key: currentSong.key,
      name: currentSong.name,
      artist: currentSong.artist,
      duration: currentSong.duration,
      filePath: currentSong.filePath,
    ));

    FavoriteBox.put(0, SongFavorite(song: FavSongs));
  }, 
  icon: SvgPicture.asset('assets/pics/Fav.svg')),
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                    onPressed: () async {
                                      // setState(() {
                                      //   isShuffle = !isShuffle;
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(
                                      //     SnackBar(
                                      //       content: Text(
                                      //         isShuffle
                                      //             ? 'Shuffle On'
                                      //             : 'Shuffle Off',
                                      //         textAlign: TextAlign.center,
                                      //         style: FontStyles.artist2,
                                      //       ),
                                      //       behavior:
                                      //           SnackBarBehavior.floating,
                                      //       margin: const EdgeInsets.only(
                                      //           bottom:300,
                                      //           left: 70,
                                      //           right: 70),
                                      //       duration: const Duration(
                                      //           milliseconds: 600),
                                      //       backgroundColor:
                                      //           const Color.fromARGB(
                                      //               131, 64, 66, 88),
                                      //       elevation: 0,
                                      //       shape:
                                      //           const RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius.all(
                                      //                       Radius.circular(
                                      //                           20.0))),
                                      //     ),
                                      //   );
                                      // });
                                      // await _audioPlayer
                                      //     .setShuffleModeEnabled(isShuffle);

                                      // await _audioPlayer.setShuffleModeEnabled(!isShuffle);
                                      // setState(() {
                                      //   isShuffle = !isShuffle;
                                      // });
                                      toggleRepeat();

                                      ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isShuffle ? 'Repeat On' : 'Repeat Off',
                      textAlign: TextAlign.center,
                      style: FontStyles.artist2,
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.only(
                      bottom: 310,
                      left: 70,
                      right: 70,
                    ),
                    duration: const Duration(milliseconds: 600),
                    backgroundColor: const Color.fromARGB(131, 64, 66, 88),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                );
                                     },
                                    icon:isShuffle
                                        ? SvgPicture.asset('assets/pics/suffleon.svg')
                                        : SvgPicture.asset('assets/pics/suffleoff.svg')),
                                    IconButton(
                                      onPressed: (){}, 
                                      icon: SvgPicture.asset('assets/pics/add list.svg')),
                                    IconButton(
                                      onPressed: (){}, 
                                      icon: SvgPicture.asset('assets/pics/share.svg',),)
                                  ],
                                ),
                              )
                      ],
                  ),
                ))
            ],
          )),
      ),
    );
  }
}