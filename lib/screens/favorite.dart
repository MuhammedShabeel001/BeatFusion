import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class favoriteScreen extends StatelessWidget {
  const favoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: Center(
        child: Text('Favorite screen',style: FontStyles.greeting,),
      ),
    );
  }
}