import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/screens/playlist2/MusicplaylistPage.dart';
import 'package:beatfusion/screens/playlist2/playlistDetails.dart';
import 'package:beatfusion/widgets/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {

  Future <void> refreshScreen()async{
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        actions: [IconButton(onPressed: (){refreshScreen();}, icon: Icon(Icons.refresh))],
        leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: SvgPicture.asset('assets/pics/back.svg')),
        title: Text('Playlist Screen',style: FontStyles.greeting,),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyTheme().secondaryColor,
            borderRadius: BorderRadius.circular(12)
          ),
          child: FutureBuilder<Box<Playlist>>(
            future: Hive.openBox<Playlist>('playlists'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No playlists available'));
              } else {
                final playlistBox = snapshot.data!;
          
                return ListView.builder(
                  itemCount: playlistBox.length,
                  itemBuilder: (context, index) {
                    final playlist = playlistBox.getAt(index);
          
                    return ListTile(
                      leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: MyTheme().primaryColor
            ),
            child: const Icon(Icons.folder,
            color: Colors.white,),
          ),
                      title: SizedBox(
            height: 18,
            child: Text(
              playlist!.name,
            style: FontStyles.name,
            maxLines: 1,),
          ),
                      subtitle: Text( 'Song Count: ${playlist.song.length}',
          style: FontStyles.artist,
          maxLines: 1,),

          trailing: IconButton(onPressed: () => PlaylistMenu(context), icon: Icon(Icons.more_vert),color: MyTheme().iconColor,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistDetailScreen(playlist),));
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme().tertiaryColor,
        
        onPressed: () async {
            setState(() {});
            showAddPlaylistDialog(context);
            // showAddOrEditPlaylistDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}