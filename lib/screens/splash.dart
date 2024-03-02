import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/Home/home_page.dart';
import 'package:beatfusion/widgets/Landing/landing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    splashtime(context);
    super.initState();
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

Future<void> splashtime(context) async {
  final shared = await SharedPreferences.getInstance();
  final key1 = shared.getBool(key);
  if (key1 == null || key1 == false) {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const Welcome1(),
      ),
    );
  } else {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => const ScreenHome(),
      ),
      (route) => false,
    );
  }
}

