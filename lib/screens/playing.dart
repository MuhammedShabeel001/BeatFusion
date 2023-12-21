import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatefulWidget {
  final String  songdata;

  final AudioPlayer audioPlayer;

  const PlayingScreen({Key? key, required this.songdata, required this.audioPlayer})
      : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double _currentSliderValue = 0.0;

  @override
  void initState(){
    super.initState();
    _audioPlayer = widget.audioPlayer;

    try{
      _audioPlayer.setUrl(widget.songdata);
      _audioPlayer.play();
      setState(() {
        isPlaying=true;
      });

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _currentSliderValue = position.inMilliseconds.toDouble();
        });
       });
    }catch(e){}
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
        return Container(
          child: AlertDialog(
            backgroundColor: MyTheme().secondaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: MyTheme().secondaryColor,
              ),
              height: 10,
              // width: 200,
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


;
  }

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.volume_up))
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

                //artwork
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
                  // color: Colors.blue,
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
                flex: 4,

                //controls
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
                          widget.songdata,
                          style: FontStyles.name2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.songdata,
                          style: FontStyles.artist2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
//                         StreamBuilder<Duration>(
//   stream: AudioPlayer.positionStream,
//   builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
//     if (snapshot.hasData) {
//       _currentSliderValue = snapshot.data?.inMilliseconds.toDouble();
//     }

//     return Slider(
//       value: _currentSliderValue,
//       min: 0.0,
//       max: _audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0,
//       onChanged: (double value) {
//         setState(() {
//           _currentSliderValue = value;
//         });
//       },
//       onChangeEnd: (double value) {
//         _audioPlayer.seek(Duration(milliseconds: value.toInt()));
//       },
//       activeColor: Colors.red,
//       inactiveColor: Colors.grey.shade500,
//     );
//   },
// ),

//                         StreamBuilder<Duration>(
//   stream: _audioPlayer.positionStream,
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       Duration? duration = snapshot.data;
//       _currentSliderValue = duration?.inMilliseconds.toDouble() ?? 0;
//     }

//     return Slider(
//       value: _currentSliderValue,
//       min: 0.0,
//       max: _audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0,
//       onChanged: (double value) {
//         setState(() {
//           _currentSliderValue = value;
//         });
//       },
//       onChangeEnd: (double value) {
//         _audioPlayer.seek(Duration(milliseconds: value.toInt()));
//       },
//       activeColor: const Color.fromARGB(255, 54, 136, 244),
//       inactiveColor: Colors.grey.shade500,
//     );
//   },
//  ),
                        Slider(
                    value: _currentSliderValue,
                    min: 0.0,
                    max:
                        _audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                    onChangeEnd: (double value) {
                      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                    },
                    activeColor: const Color.fromARGB(255, 54, 136, 244),
                    inactiveColor: Colors.grey.shade500,
                  ),
                    
                          SizedBox(height: 5,),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    // await _audioPlayer.previousIndex;
                                    int newPosition =
                                (_audioPlayer.position.inSeconds - 10).toInt();
                            if (newPosition <
                                _audioPlayer.duration!.inSeconds) {
                              _audioPlayer.seek(Duration(seconds: newPosition));
                              setState(() {
                                _currentSliderValue = newPosition.toDouble();
                              });}
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
                                    // await _audioPlayer.nextIndex;
                                    int newPosition =
                                (_audioPlayer.position.inSeconds + 10).toInt();
                            if (newPosition <
                                _audioPlayer.duration!.inSeconds) {
                              _audioPlayer.seek(Duration(seconds: newPosition));
                              setState(() {
                                _currentSliderValue = newPosition.toDouble();
                              });}
                                  },
                                  icon: SvgPicture.asset('assets/pics/next.svg')),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    //favorite
                                    IconButton(
                                      onPressed: (){}, 
                                      icon: SvgPicture.asset('assets/pics/Fav.svg')),
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                    onPressed: () async {
                                      setState(() {
                                        isShuffle = !isShuffle;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            
                                            content: Text(
                                              isShuffle
                                                  ? 'Shuffle On'
                                                  : 'Shuffle Off',
                                              textAlign: TextAlign.center,
                                              style: FontStyles.artist2,
                                            ),
                                            behavior:
                                                SnackBarBehavior.floating,
                                            margin: const EdgeInsets.only(
                                                bottom:300,
                                                left: 70,
                                                right: 70),
                                            duration: const Duration(
                                                milliseconds: 600),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    131, 64, 66, 88),
                                            elevation: 0,
                                            shape:
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
                                          ),
                                        );
                                      });
                                      await _audioPlayer
                                          .setShuffleModeEnabled(isShuffle);
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
                  // color: Colors.green,
                ))
            ],
          )),

      ),
    );
  }

}