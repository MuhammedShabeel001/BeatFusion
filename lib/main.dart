import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/song.dart';
// import 'package:beatfusion/screens/Landing/screen2.dart';
// import 'package:beatfusion/screens/Landing/screen3.dart';
// import 'package:beatfusion/database/hive_setup.dart';
// import 'package:beatfusion/screens/home_page.dart';
import 'package:beatfusion/screens/splash.dart';
import 'package:beatfusion/screens/test.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Hive.registerAdapter(favoriteAdapter());
  Hive.registerAdapter(SongAdapter());
  
  Hive.openBox<Song>('songs');
  // Hive.openBox<Song>('song'); 
  
  Hive.openBox<favorite>('favorites');
  runApp(const BeatFusion());
}

class BeatFusion extends StatelessWidget {
  const BeatFusion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatFusion',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: MyTheme().primaryColor,
          
        )
      ),
      home: const SplashScreen(),
      // home: MusicPlaySong(song: , audioPlayer: audioPlayer),
    );
  }
}