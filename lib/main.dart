import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BeatFusion());
}

class BeatFusion extends StatelessWidget {
  const BeatFusion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatFusion',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: MyTheme().primaryColor,
          
        )
      ),
      home: const ScreenHome(),
    );
  }
}