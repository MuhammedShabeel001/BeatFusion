import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/playlist.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:beatfusion/widgets/Library/playlist/musicplaylist_page.dart';
import 'package:beatfusion/widgets/Library/playlist/playlist_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {

  Future <void> refreshScreen11()async{
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      // backgroundColor: Colors.amber,
        appBar: AppBar(
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
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistDetailScreen(playlist)));},
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
                            trailing: IconButton(
                              onPressed: (){
                                PlaylistMenu(context, playlist, refreshScreen11,);
                              }, 
                                icon: Icon(Icons.more_vert),color: MyTheme().iconColor,)
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
          },
            child: Icon(Icons.add),
      ),
    );
  }
}