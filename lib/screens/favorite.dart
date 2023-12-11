import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
// import 'package:beatfusion/database/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        title: Text('Recent'),
      ),
      body: Center(
        child: Text('Favorite screen',style: FontStyles.greeting,),
      ),
    );
  }
}

