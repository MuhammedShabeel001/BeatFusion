import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/screens/Landing/screen1.dart';
import 'package:beatfusion/screens/Landing/screen3.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';

class LandingTwo extends StatelessWidget {
  // Song song;
  // LandingTwo({required this.song});
  const LandingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ScreenHome(),), (route) => false);
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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/pics/71.png'),
            SizedBox(height: 100,),
            Container(
              decoration: BoxDecoration(
                color: MyTheme().secondaryColor,
                borderRadius: BorderRadius.circular(12)
              ),
              width: double.infinity,
              // height: 200,
              padding: EdgeInsets.all(15),
              // color: Colors.amber,
              child: Column(
                children: [
                  Text(
                    '''We provide a better 
audio experience 
than others''',
                    textAlign: TextAlign.center,
                    style: FontStyles.landing,
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Adjust the value for the desired roundness
                        ),
                      )
                    ),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingThree(),), (route) => false);
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