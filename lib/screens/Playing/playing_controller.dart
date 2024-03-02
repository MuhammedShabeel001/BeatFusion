import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/favorite.dart';
import 'package:beatfusion/database/song.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';

bool favoriteBoxContainsSong(Song song) {
  var favoriteBox = Hive.box<SongFavorite>('FavouriteSong');
  return favoriteBox.get(0)?.song.any((s) => s.filePath == song.filePath) ?? false;
}

void showSnackbar(String message) {
  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: FontStyles.artist2,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 310,
        left: 70,
        right: 70,
      ),
      duration: const Duration(milliseconds: 600),
      backgroundColor: const Color.fromARGB(131, 64, 66, 88),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    ),
  );
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

 List<Song> getSongBoxAsList(){
    var songBox = Hive.box<Song>('songsbox');
    List<Song> songsList = [];
    for (int i=0; i<songBox.length; i++){
      songsList.add(songBox.getAt(i)!);
    }
    return songsList;
  }


  int findcurrentSongIndex(Song song) {
    var songsList = getSongBoxAsList();
    for (int i = 0; i < songsList.length; i++) {
      if (songsList[i].filePath == song.filePath) {
        return i;
      }
    }
    return -1;
  }

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
  showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            backgroundColor: MyTheme().secondaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 10,
              child: StreamBuilder<double>(
                stream: stream,
                builder: (context, snapshot) {
                  return Slider(
                    min: min,
                    max: max,
                    divisions: divisions,
                    value: snapshot.hasData ? snapshot.data! : value,
                    onChanged: onChanged,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  