import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      appBar: AppBar(
        title: Text('Recent'),
      ),
      body: Center(
        child: Text('Recent screen',style: FontStyles.greeting,),
      ),
    );
  }
}