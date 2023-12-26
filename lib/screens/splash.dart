import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/Landing/screen1.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    goToLandingPage().then((value){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LandingOne(),)
      );
    });
  }

  Future<void> goToLandingPage()async{
    await Future.delayed(const Duration(seconds: 5));
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