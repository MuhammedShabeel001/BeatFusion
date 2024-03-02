import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:beatfusion/screens/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
const key = 'success';

class Welcome1 extends StatefulWidget {
  const Welcome1({super.key});

  @override
  State<Welcome1> createState() => _Welcome1State();
}

class _Welcome1State extends State<Welcome1> {
  final PageController _controller = PageController();

  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  Future<void> requestStoragePermission() async {
    final PermissionStatus status = await Permission.audio.request();
    final PermissionStatus status1 = await Permission.storage.request();
    if (status.isGranted || status1.isGranted) {
      await fetchSongs();
      final shared = await SharedPreferences.getInstance();
      shared.setBool(key,true);
    }
    if (status.isDenied && status1.isDenied) {
      await openAppSettings();
    }
    if (status.isPermanentlyDenied || status1.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: PageView(
          controller: _controller,
          children: [
            Stack(
              children: [
                Container(
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
                                    _controller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeInOutQuad);
                                  }, 
                                    child: Text('Next',style: FontStyles.greeting,))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
              ],
            ),
            Stack(
            children: [
                Container(
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
                                  '''We provide a better 
audio experience 
than others''',
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
                                        borderRadius: BorderRadius.circular(8.0), 
                                      ),
                                    )
                                  ),
                                  onPressed: ()async{
                                    _controller.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeInOutQuad);
                                  }, 
                                    child: Text('Next',style: FontStyles.greeting,))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Stack(
            children: [
                Container(
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
                                  onPressed: ()async {
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ScreenHome(),), (route) => false);
                                  }, 
                                    child: Text('Get inside',style: FontStyles.greeting,))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
