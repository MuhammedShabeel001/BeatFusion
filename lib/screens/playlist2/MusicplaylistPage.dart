import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/playlist2/songsPLaylist.dart';
import 'package:flutter/material.dart';

Future<void> showAddPlaylistDialog(BuildContext context) async {
  TextEditingController playlistNameController = TextEditingController();
  bool isButtonEnabled = false;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: MyTheme().tertiaryColor,
            title: Text('Add Playlist',style: TextStyle(color: MyTheme().primaryColor),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: playlistNameController,
                  onChanged: (text) {
                    setState(() {
                      isButtonEnabled = text.trim().isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter playlist name',
                    errorText: isButtonEnabled ? null : '',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',style: TextStyle(color: MyTheme().secondaryColor),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Add',),
                onPressed: isButtonEnabled
                    ? () {
                        String playlistName =
                            playlistNameController.text.trim();
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SongsPlayList(ListName: playlistName)),
                        );
                      }
                    : null,
              ),
            ],
          );
        },
      );
    },
  );
}