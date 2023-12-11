import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/Landing/screen1.dart';
import 'package:beatfusion/screens/favorite.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    goToLandingPage().then((value){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LandingOne(),)
      );
    });
  }

  Future<void> goToLandingPage()async{
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/pics/BF.png',height: 180,),
            Image.asset('assets/pics/BF-typo.png',height: 180,)
          ],
        ),
      )
    );
  }
}