import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(SongAdapter());
  Hive.registerAdapter(PlaylistAdapter());
  Hive.registerAdapter(SongHistoryAdapter());
  // Hive.registerAdapter(SongFavoriteAdapter());
  
  await Hive.openBox<Song>('songsbox');
  await Hive.openBox<Playlist>('playlistbox');
  await Hive.openBox<SongHistory>('history');
  // await Hive.openBox<SongFavorite>('song_favorite_box');
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
      // home:  SplashScreen(),
      home: const ScreenHome(),
    );
  }
}