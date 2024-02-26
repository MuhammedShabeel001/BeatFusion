import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(SongAdapter());
  Hive.registerAdapter(SongFavoriteAdapter());
  Hive.registerAdapter(PlaylistAdapter());
  Hive.registerAdapter(SongHistoryAdapter());
  
  
  await Hive.openBox<Song>('songsbox');
  await Hive.openBox<SongFavorite>('FavouriteSong');
  await Hive.openBox<Playlist>('playlistbox');
  await Hive.openBox<SongHistory>('history');

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
      home:  SplashScreen(),
      // home: const ScreenHome(),
    );
  }
}