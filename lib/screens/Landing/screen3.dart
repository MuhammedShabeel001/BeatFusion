import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';

class LandingThree extends StatelessWidget {
  const LandingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    '''Listen to the best 
audio & music with 
Beatfusion now!''',
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
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ScreenHome(),), (route) => false);
                    }, 
                    child: Text('Get inside',style: FontStyles.greeting,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}