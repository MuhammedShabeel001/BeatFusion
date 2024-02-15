import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
// import 'package:beatfusion/screens/Landing/screen2.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:beatfusion/widgets/Landing/screen2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingOne extends StatelessWidget {
  const LandingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _shouldShowScreens(), 
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (snapshot.data == true) {
          return _buildLandingOne(context);
        }else{
          return ScreenHome();
        }
      });
  }

  Future<bool> _shouldShowScreens()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenScreens') ?? true;
  }

  Widget _buildLandingOne(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ScreenHome(),), (route) => false);
            }, 
            child: Text(
              'skip',
              style: FontStyles.name2,
            ))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: MyTheme().primaryColor,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/pics/71.png'),
            const SizedBox(height: 100,),
            Container(
              decoration: BoxDecoration(
                color: MyTheme().secondaryColor,
                borderRadius: BorderRadius.circular(12)
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    '''User friendly mp3 
music player for 
your device''',
                    textAlign: TextAlign.center,
                    style: FontStyles.landing,
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Adjust the value for the desired roundness
                        ),
                      )
                    ),
                    onPressed: ()async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('hasSeenScreens', true);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingTwo(),), (route) => false);
                    }, 
                    child: Text('Next',style: FontStyles.greeting,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

