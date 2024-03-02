import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:beatfusion/screens/Playing/playing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';

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

  void toggleFavorite(Song song) async {
    var favoriteBox = await Hive.openBox<SongFavorite>('FavouriteSong');
    var currentSong = song;
    bool isFavorite = favoriteBox.get(0)?.song.any((s) => s.filePath == currentSong.filePath) ?? false;
    if (isFavorite) {
      var favoriteSongs = favoriteBox.get(0)?.song ?? [];
      favoriteSongs.removeWhere((s) => s.filePath == currentSong.filePath);
      favoriteBox.put(0, SongFavorite(song: favoriteSongs));
      showSnackbar('Removed from Favorites');
    } else {
      var favoriteSongs = favoriteBox.get(0)?.song ?? [];
      favoriteSongs.add(currentSong);
      favoriteBox.put(0, SongFavorite(song: favoriteSongs));
      showSnackbar('Added to Favorites');
    }
  setState(() {});
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
 _audioPlayer.durationStream.listen((duration) {
  if (duration == _audioPlayer.position) {
    // Check if repeat is on
    if (isRepeating) {
      // If repeat is on, seek to the beginning of the song
      _audioPlayer.seek(Duration.zero);
      _audioPlayer.play();
    } else {
      // If repeat is off, play the next song
      playNext();
    }
  }
});

  });    
    // ignore: empty_catches
    }catch(e){
    }
  }

void toggleRepeat() async {
  setState(() {
    isRepeating = !isRepeating;
  });

  // Check if the audio player is playing
  if (isPlaying) {
    // If repeat is turned on, seek to the beginning of the song
    if (isRepeating) {
      await _audioPlayer.play();
    }
    // If repeat is turned off, do nothing and let the current song continue playing
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isRepeating ? 'Repeat On' : 'Repeat Off',
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
    // repeatSong();
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
    // repeatSong();
  }

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

  @override
  Widget build(BuildContext context) {
    var playBox = Hive.box<Song>('songsbox');
    int findCurrentSongIndex(String filePath) {
      for (int i = 0; i < playBox.length; i++) {
        if (playBox.getAt(i)?.filePath == filePath) {
          return i;
        }
      }
      return -1;
    }
 
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
        appBar: AppBar(
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: (){
                Navigator.pop(context);
              }, 
                icon: SvgPicture.asset('assets/pics/back.svg'),),
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
                            borderRadius: BorderRadius.circular(12)),
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
                                        if (currentIndex != -1 && currentIndex < playBox.length-1){
                                          playNext();
                                        }
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
                                        IconButton(
                                          onPressed: () async {
                                            toggleFavorite(widget.songdata);
                                          }, 
                                            icon: Icon(
                                              favoriteBoxContainsSong(widget.songdata)
                                                ? Icons.favorite
                                                : Icons.favorite_border    
                                          )),
                                        IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: () async {
                                            toggleRepeat();
                                            // repeatSong();
                                            // ScaffoldMessenger.of(context).showSnackBar(
                                            // SnackBar(
                                              
                                            //     content: Text(
                                            //       isRepeating ? 'Repeat On' : 'Repeat Off',
                                            //       textAlign: TextAlign.center,
                                            //       style: FontStyles.artist2,
                                            //     ),
                                            //     behavior: SnackBarBehavior.floating,
                                            //     margin: const EdgeInsets.only(
                                            //       bottom: 310,
                                            //       left: 70,
                                            //       right: 70,
                                            //     ),
                                            //     duration: const Duration(milliseconds: 600),
                                            //     backgroundColor: const Color.fromARGB(131, 64, 66, 88),
                                            //     elevation: 0,
                                            //     shape: const RoundedRectangleBorder(
                                            //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            //       ),
                                            //     ),
                                            //   );
                                            },
                                            icon:isRepeating
                                            ? SvgPicture.asset('assets/pics/repeat on.svg')
                                            : SvgPicture.asset('assets/pics/repeate off.svg')),
                                        IconButton(
                                          onPressed: () => playlistBottom(context,widget.songdata), 
                                            icon: SvgPicture.asset('assets/pics/add list.svg')),                         
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