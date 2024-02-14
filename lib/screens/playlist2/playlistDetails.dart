import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/playing.dart';
import 'package:beatfusion/screens/playlist2/songsPLaylist.dart';
import 'package:beatfusion/widgets/controller.dart';
import 'package:flutter/material.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final Playlist playlist;

   PlaylistDetailScreen(this.playlist);

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  
  final AudioPlayer player = AudioPlayer();
  void refreshScreen(){
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyTheme().primaryColor,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            // refreshScreen();
            Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SongsPlayList(ListName: widget.playlist.name)),);
          }, icon: Icon(Icons.add),color: MyTheme().iconColor,)
        ],
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: SvgPicture.asset('assets/pics/back.svg')),
        title: Text('Songs',style: FontStyles.greeting,),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyTheme().secondaryColor
          ),
          child: ListView.builder(
            itemCount: widget.playlist.song.length,
            itemBuilder: (context, index) {
              final song = widget.playlist.song[index];
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => 
                   PlayingScreen(songdata: 
                  Song(key: song.key, name: song.name, artist: song.artist, duration: song.duration, filePath: song.filePath),
                   audioPlayer: player),
                   ));
                },
                trailing: IconButton(onPressed: () => addListPlaylist(context), icon:Icon(Icons.more_vert),color: MyTheme().iconColor,),
              );
            },
          ),
        ),
      ),
    );
  }
}