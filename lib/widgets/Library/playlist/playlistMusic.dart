import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/playlist.dart';
// import 'package:beatfusion/screens/Library/playlist/MusicplaylistPage.dart';
// import 'package:beatfusion/screens/Library/playlist/playlistDetails.dart';
// import 'package:beatfusion/functions/controller.dart';
import 'package:beatfusion/widgets/Library/playlist/MusicplaylistPage.dart';
import 'package:beatfusion/widgets/Library/playlist/playlistDetails.dart';
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

  Future<void> deletePlaylist(BuildContext context, String playlistName) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete the playlist "${playlistName}"?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Delete playlist from Hive
              final playlistBox = await Hive.openBox<Playlist>('playlists');
              await playlistBox.delete(playlistName);
              await playlistBox.close();

              // Update the UI
              setState(() {});

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog without deleting the playlist
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
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
      // ... other properties remain unchanged
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaylistDetailScreen(playlist),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward),
            color: MyTheme().iconColor,
          ),
          SizedBox( // Added SizedBox with fixed width to prevent the error
            width: 48, // Adjust the width as needed
            child: IconButton(
              onPressed: () {
                deletePlaylist(context,playlist.name);
              },
              icon: Icon(Icons.delete),
              color: MyTheme().iconColor,
            ),
          ),
        ],
      ),
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