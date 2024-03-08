import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:beatfusion/screens/Playing/playing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart'; 

class FavoriteSongsScreen extends StatefulWidget {
  const FavoriteSongsScreen({super.key});

  
  @override
  State<FavoriteSongsScreen> createState() => _FavoriteSongsScreenState();
}

class _FavoriteSongsScreenState extends State<FavoriteSongsScreen> {

  void refreshFavouriteScreen(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
        appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: SvgPicture.asset('assets/pics/back.svg')),
            title: Text('Favourite Songs',style: FontStyles.greeting,),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding:const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyTheme().secondaryColor
              ),
                child: FutureBuilder(
                  future: Hive.openBox<SongFavorite>('FavouriteSong'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                    var favoriteBox = Hive.box<SongFavorite>('FavouriteSong');
                    var favoriteSongs = favoriteBox.get(0)?.song ?? [];    
                    return ListView.builder(
                      itemCount: favoriteSongs.length,
                      itemBuilder: (context, index) {
                      var song = favoriteSongs[index];
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
                              onPressed: () => favouriteList(context,song,refreshFavouriteScreen), 
                                icon: Icon(Icons.more_vert,
                                color: MyTheme().iconColor,)),
                            onTap: () {
                              Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => PlayingScreen(songdata: song, audioPlayer: AudioPlayer(),
                              ), ));
                            },
                          );
                        },
                      );
                    } else {
                    return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
