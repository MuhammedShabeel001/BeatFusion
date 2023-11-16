import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class playlistScreen extends StatelessWidget {
  const playlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      body: Center(
        child: Text('Playlist screen',style: FontStyles.greeting,),
      ),
    );
  }
}