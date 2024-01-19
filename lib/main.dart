import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/Landing/screen1.dart';
import 'package:beatfusion/screens/Landing/screen2.dart';
import 'package:beatfusion/screens/Landing/screen3.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:beatfusion/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(SongAdapter());
  Hive.registerAdapter(PlaylistAdapter());
  Hive.registerAdapter(SongHistoryAdapter());
  // Hive.registerAdapter(SongFavoriteAdapter());
  // await openBoxes();
  
  await Hive.openBox<Song>('songsbox');
  await Hive.openBox<Playlist>('playlistbox');
  await Hive.openBox<SongHistory>('history');
  await Hive.openBox<SongFavorite>('song_favorite_box');
  runApp(const BeatFusion());
}



class BeatFusion extends StatelessWidget {
  const BeatFusion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/splash',
      // routes: {
      //   '/splash' : (context) => SplashScreen(),
      //   '/landing1' : (context) => const LandingOne(),
      //   '/landing2' : (context) => const LandingTwo(),
      //   '/landing3' : (context) => const LandingThree(),
      //   '/home' : (context) => const ScreenHome()
      // },
      title: 'BeatFusion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: MyTheme().primaryColor,
        )
      ),
      // home:  SplashScreen(),
      home: ScreenHome(),
    );
  }
}