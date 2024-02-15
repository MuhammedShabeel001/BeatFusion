import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
// import 'package:beatfusion/screens/Library/library.dart';
// import 'package:beatfusion/screens/Settings/settings.dart';
import 'package:beatfusion/screens/search.dart';
import 'package:beatfusion/screens/library.dart';
import 'package:beatfusion/widgets/Settings/settings.dart';
import 'package:beatfusion/widgets/Songs/list_of_songs.dart';
// import 'package:beatfusion/widgets/list_of_songs.dart';
// import 'package:beatfusion/widgets/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> with SingleTickerProviderStateMixin {

  int currentSongID = 0;
  late TabController _tabController;
  Widget? permissionResult; 
  final OnAudioQuery _audioQuery = OnAudioQuery();

  requestStoragePermission() async{
    if(!kIsWeb){
      bool permissionStatus = await _audioQuery.permissionsStatus();
      setState(() {
        permissionResult =const Center(
          child: CircularProgressIndicator(),
        );
      });
  
      if(!permissionStatus){
        setState(() {
          permissionResult = Column(
            children: [
              Text(
                'Access Denied External Storage',
                style: FontStyles.text,
              ),
              TextButton(
                onPressed: ()async{
                  await _audioQuery.permissionsRequest();
                  requestStoragePermission();
                },
                style: TextButton.styleFrom(
                  backgroundColor: MyTheme().buttonColor
                ),
                 child: Text(
                  'Request Access',
                  style: FontStyles.text,
                 ))
            ],
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, 
      vsync: this);
    requestStoragePermission();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  defaultSongs(defaultsong){
    setState(() {
      search = defaultsong.data!;
    });
  }
bool isHome = true;
bool isSearch = false;

final AudioPlayer _player = AudioPlayer();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyTheme().primaryColor,
      drawer: const SettingsScreen(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyTheme().appBarColor,
        title: Text(
          '${getTimeOfDay()},',
          style: FontStyles.greeting,
        ),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: (){
               
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ScreenSearch(),));
             }, 
            icon: SvgPicture.asset('assets/pics/search.svg')),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
            }, 
            icon: Icon(Icons.settings_rounded,
            color: MyTheme().iconColor,))
        ],
        bottom: TabBar(
                splashFactory: NoSplash.splashFactory,
                controller: _tabController,            
                unselectedLabelColor: MyTheme().secondaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyTheme().secondaryColor),
                tabs: [
                  Tab(
                    
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyTheme().secondaryColor, width: 3)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Songs",
                          style: FontStyles.button,
                          ),
                      ),
                    ),
                  ),
                  Tab(
                    
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyTheme().secondaryColor, width: 3)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Library",
                          style: FontStyles.button,),
                      ),
                    ),
                  ),
                ]),
      ),
      body:Container(
        padding: const EdgeInsets.all(10),

        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyTheme().secondaryColor,
            borderRadius: BorderRadius.circular(12)
          ),
          child: TabBarView(
            
            controller: _tabController,
            children:  [
            const SongsList(),
            LibraryScreen()
          ],),
        ),
      ),
      bottomSheet: isPlayerViewVisible
      
          ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyTheme().primaryColor,
              borderRadius: BorderRadius.circular(0)
            ),
            child: Container(
                child: isMusicPlayerTapped 
                    ? Stack(
                      
                      children: [
                        GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyTheme().secondaryColor,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  id: currentSongID,
                                  keepOldArtwork: true,
                                  type: ArtworkType.AUDIO,
                                  artworkBorder: BorderRadius.zero,
                                  nullArtworkWidget: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        shape: BoxShape.rectangle,
                                        color: const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      child: const Icon(
                                        Icons.music_note_sharp,
                                        color: Colors.white,
                                      )),
                                ),
                                title: SizedBox(
                                  height: 18,
                                  child: currentSongTitle.length > 20
                                      ? Marquee(
                                          text: (currentSongTitle)
                                                  .replaceAll('_', ' ') +
                                              ('      '),
                                          style: FontStyles.name,
                                          fadingEdgeStartFraction: 0.2,
                                          fadingEdgeEndFraction: 0.2,
                                          scrollAxis: Axis.horizontal,
                                        )
                                      : Text(
                                          currentSongTitle,
                                          style: FontStyles.name,
                                          maxLines: 1,
                                        ),
                                ),
                                subtitle: Text(
                                  currentArtist ?? "No Artist",
                                  style: FontStyles.artist,
                                  maxLines: 1,
                                ),
                                trailing: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isPlaying
                                        ? IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                isPlaying = !isPlaying;
                                                const ScreenHome();
                                              });
                                              await _player.pause();
                                            },
                                            icon: SvgPicture.asset('assets/pics/pause.svg'),
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                isPlaying = !isPlaying;
                                                const ScreenHome();
                                              });
                                              await _player.play();
                                            },
                                            icon: SvgPicture.asset('assets/pics/play.svg')),
                                    IconButton(
                                      onPressed: () async {
                                        await _player.seekToNext();
                                        const ScreenHome();
                                      },
                                      icon:SvgPicture.asset('assets/pics/next2.svg')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                    :null

            ),
          )
          :null,
    
      );
  }
}