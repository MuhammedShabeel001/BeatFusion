import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/Landing/screen2.dart';
// import 'package:beatfusion/screens/Landing/screen2.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:beatfusion/widgets/list_of_songs.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LandingOne extends StatelessWidget {
  const LandingOne({super.key});
  // List<SongModel> songs;
  // LandingOne({required this.songs});

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
                    '''User friendly mp3 
music player for 
your device''',
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
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingTwo(),), (route) => false);
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

