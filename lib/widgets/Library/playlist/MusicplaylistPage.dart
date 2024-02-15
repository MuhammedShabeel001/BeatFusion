import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/widgets/Library/playlist/songsPLaylist.dart';
// import 'package:beatfusion/screens/Library/playlist/songsPLaylist.dart';
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

// import 'package:flutter/material.dart';

// Future<void> showAddOrEditPlaylistDialog(BuildContext context, {String? initialName}) async {
//   TextEditingController playlistNameController = TextEditingController();
//   bool isButtonEnabled = initialName?.isNotEmpty ?? false;

//   if (initialName != null) {
//     playlistNameController.text = initialName;
//   }

//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text(initialName != null ? 'Edit Playlist' : 'Add Playlist'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: playlistNameController,
//                   onChanged: (text) {
//                     setState(() {
//                       isButtonEnabled = text.trim().isNotEmpty;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Enter playlist name',
//                     errorText: isButtonEnabled ? null : '',
//                   ),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: Text(initialName != null ? 'Save' : 'Add'),
//                 onPressed: isButtonEnabled
//                     ? () {
//                         String newPlaylistName = playlistNameController.text.trim();
//                         Navigator.of(context).pop(newPlaylistName);
//                       }
//                     : null,
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }


// void showEditPlaylistDialog(BuildContext context, String currentName) async {
//   String? editedName = await showAddOrEditPlaylistDialog(context, initialName: currentName);

//   if (editedName != null) {
//     // Handle the edited playlist name
//     // Update the playlist name in the database or perform any necessary actions
//     print('Edited playlist name: $editedName');
//   }
// }


Future<void> showAddOrEditPlaylistDialog(BuildContext context, {String? initialName}) async {
  TextEditingController playlistNameController = TextEditingController();
  bool isButtonEnabled = initialName?.isNotEmpty ?? false;

  if (initialName != null) {
    playlistNameController.text = initialName;
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(initialName != null ? 'Edit Playlist' : 'Add Playlist'),
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
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(initialName != null ? 'Save' : 'Add'),
                onPressed: isButtonEnabled
                    ? () {
                        String newPlaylistName = playlistNameController.text.trim();
                        Navigator.of(context).pop(newPlaylistName);
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
