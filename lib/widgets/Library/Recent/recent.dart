import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/history.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

class RecentScreen extends StatelessWidget {

  final AudioPlayer player = AudioPlayer();

  RecentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: SvgPicture.asset('assets/pics/back.svg')),
        title: Text('Recent Songs',style: FontStyles.greeting,),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyTheme().secondaryColor
          ),
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
            future: Hive.openBox<SongHistory>('history'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var historyBox = Hive.box<SongHistory>('history');
                var recentSongs = historyBox.get(0)?.RecentSong ?? [];
                recentSongs = recentSongs.reversed.toList();
                return ListView.builder(
                  itemCount: recentSongs.length,
                  itemBuilder: (context, index) {
                    var song = recentSongs[index];
                    return ListTile(
                      leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: MyTheme().primaryColor
            ),
            child: const Icon(Icons.music_note_rounded,
            color: Colors.white,),
          ),
                      title: SizedBox(
            height: 18,
            child: Text(
              song.name,
            style: FontStyles.name,
            maxLines: 1,),
          ),
                      subtitle: Text( song.artist,
          style: FontStyles.artist,
          maxLines: 1,),
          trailing: IconButton(
            onPressed: () => addList(context,song), 
            icon: Icon(Icons.more_vert,
            color: MyTheme().iconColor,)),

          onTap: () {
            Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => 
      PlayingScreen(
        songdata: Song(key: song.key, name: song.name, artist: song.artist, duration: song.duration, filePath: song.filePath),
        audioPlayer: player,
      ),
    ),
  );
          },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
