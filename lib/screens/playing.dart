import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({super.key});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {

  final AudioPlayer _player = AudioPlayer();

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          _player.positionStream,
          _player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  isMusicPlayerTapped =
                      !isMusicPlayerTapped;
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => ScreenHome(),), (route) => false);
                });
              },
              icon: SvgPicture.asset('assets/pics/back.svg'),),
        
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
                  child: QueryArtworkWidget(
                    id: currrentSongID,
                    keepOldArtwork: true, 
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(9),
                    nullArtworkWidget: Container(
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
                          currentSongTitle.replaceAll('_', ' '),
                          style: FontStyles.name2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          currentArtist ?? "Unknown artist",
                          style: FontStyles.artist2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10
                          ),
                          child: StreamBuilder<DurationState>(
                            stream: _durationStateStream,
                            builder: (context, snapshot) {
                              final durationState = snapshot.data;
                              final progress =
                                    durationState?.position ??
                                        Duration.zero;
                              final total = 
                                  durationState?.total ?? Duration.zero;

                              return ProgressBar(
                                onSeek: (duration){
                                  _player.seek(duration);
                                },
                                progress: progress, 
                                total: total,
                                barHeight: 7,
                                thumbRadius: 7,
                                timeLabelLocation: TimeLabelLocation.below,
                                timeLabelTextStyle: FontStyles.artist2,
                                baseBarColor: MyTheme().progressBaseColor,
                                progressBarColor: MyTheme().progressBarColor,
                                thumbColor: Colors.white,
                                );

                            },
                          ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await _player.seekToPrevious();
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
                                          await _player.pause();
                                        },
                                        icon: SvgPicture.asset('assets/pics/pauseblack.svg'),
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            isPlaying = !isPlaying;
                                          });
                                          await _player.play();
                                        },
                                        icon: SvgPicture.asset('assets/pics/playblack.svg')),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await _player.seekToNext();
                                  },
                                  icon: SvgPicture.asset('assets/pics/next.svg')),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Container(
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
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
                                      await _player
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
