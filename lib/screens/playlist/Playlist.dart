import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/playlist/playlist_controller.dart';
import 'package:flutter/material.dart';

class playlistScreen extends StatelessWidget {
  const playlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        title: const Text('Recent'),
      ),
      body: Center(
        child: Text('Playlist',),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showalert(context);
        }) ,
    );
  }
}