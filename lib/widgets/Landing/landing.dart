// import 'dart:html';=

import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/controller.dart';
import 'package:beatfusion/screens/home_page.dart';
// import 'package:beatfusion/widgets/Landing/screen1.dart';
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
      // ignore: use_build_context_synchronously
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
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // prefs.setBool('hasSeenScreens', true);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingTwo(),), (route) => false);
                    }, 
                    child: Text('Next',style: FontStyles.greeting,))
                ],
              ),
            )
          ],
        ),
      ),
              // Container(
              //   color: Colors.black,
              //   width: double.infinity,
              //   height: double.infinity,
              //   child: Column(
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         height: 510,
              //         decoration: const BoxDecoration(
              //             image: DecorationImage(
              //                 image: AssetImage('assets/images/new.webp'),
              //                 fit: BoxFit.cover)),
              //       ),
              //     ],
              //   ),
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 320,
              //       width: double.infinity,
              //       decoration: const BoxDecoration(
              //           color: Colors.black,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(30),
              //               topRight: Radius.circular(30))),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           const Text(
              //             'User friendly mp3',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const Text(
              //             'music player for',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const Text(
              //             'your device',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Container(
              //             alignment: const Alignment(0, 0.7),
              //             child: SmoothPageIndicator(
              //               controller: _controller,
              //               count: 3,
              //               effect: const WormEffect(
              //                   dotColor: Colors.white,
              //                   dotHeight: 10,
              //                   dotWidth: 15,
              //                   activeDotColor:
              //                       Color.fromARGB(255, 255, 111, 0)),
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   backgroundColor:
              //                       const Color.fromARGB(255, 255, 111, 0),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(20)),
              //                   minimumSize: const Size(300, 50)),
              //               onPressed: () {
              //                 _controller.nextPage(
              //                     duration: const Duration(microseconds: 500),
              //                     curve: Curves.easeIn);
              //               },
              //               child: const Text(
              //                 'Next',
              //                 style:
              //                     TextStyle(fontSize: 18, color: Colors.white),
              //               )),
              //           TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (ctx) => const Maniscreen()));
              //               },
              //               child: const Text(
              //                 'Skip',
              //                 style:
              //                     TextStyle(fontSize: 17, color: Colors.white),
              //               )),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
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
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // prefs.setBool('hasSeenScreens', true);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LandingThree(),), (route) => false);
                    }, 
                    child: Text('Next',style: FontStyles.greeting,))
                ],
              ),
            )
          ],
        ),
      ),
              // Container(
              //   color: Colors.black,
              //   width: double.infinity,
              //   height: double.infinity,
              //   child: Column(
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         height: 510,
              //         decoration: const BoxDecoration(
              //             image: DecorationImage(
              //                 image: AssetImage('assets/images/new.webp'),
              //                 fit: BoxFit.cover)),
              //       ),
              //     ],
              //   ),
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 320,
              //       width: double.infinity,
              //       decoration: const BoxDecoration(
              //           color: Colors.black,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(30),
              //               topRight: Radius.circular(30))),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           const Text(
              //             'We provide a better',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const Text(
              //             'audio experience',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const Text(
              //             'than others',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Container(
              //             alignment: const Alignment(0, 0.7),
              //             child: SmoothPageIndicator(
              //               controller: _controller,
              //               count: 3,
              //               effect: const WormEffect(
              //                   dotColor: Colors.white,
              //                   dotHeight: 10,
              //                   dotWidth: 15,
              //                   activeDotColor:
              //                       Color.fromARGB(255, 255, 111, 0)),
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   backgroundColor:
              //                       const Color.fromARGB(255, 255, 111, 0),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(20)),
              //                   minimumSize: const Size(300, 50)),
              //               onPressed: () {
              //                 _controller.nextPage(
              //                     duration: const Duration(microseconds: 500),
              //                     curve: Curves.easeIn);
              //               },
              //               child: const Text(
              //                 'Next',
              //                 style:
              //                     TextStyle(fontSize: 18, color: Colors.white),
              //               )),
              //           TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (ctx) => const Maniscreen()));
              //               },
              //               child: const Text(
              //                 'Skip',
              //                 style:
              //                     TextStyle(fontSize: 17, color: Colors.white),
              //               )),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
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

                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // prefs.setBool('hasSeenScreens', true);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ScreenHome(),), (route) => false);
                    }, 
                    child: Text('Get inside',style: FontStyles.greeting,))
                ],
              ),
            )
          ],
        ),
      ),

              // Container(
              //   color: Colors.black,
              //   width: double.infinity,
              //   height: double.infinity,
              //   child: Column(
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         height: 510,
              //         decoration: const BoxDecoration(
              //             image: DecorationImage(
              //                 image: AssetImage('assets/images/new.webp'),
              //                 fit: BoxFit.cover)),
              //       ),
              //     ],
              //   ),
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 320,
              //       width: double.infinity,
              //       decoration: const BoxDecoration(
              //           color: Colors.black,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(30),
              //               topRight: Radius.circular(30))),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           const Text(
              //             'Listen to the best',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const Text(
              //             'audio & music with',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const Text(
              //             'Slashi now!',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontFamily: 'WELCOME',
              //                 fontSize: 35),
              //           ),
              //           const SizedBox(
              //             height: 10,
              //           ),
              //           Container(
              //             alignment: const Alignment(0, 0.7),
              //             child: SmoothPageIndicator(
              //               controller: _controller,
              //               count: 3,
              //               effect: const WormEffect(
              //                   dotColor: Colors.white,
              //                   dotHeight: 10,
              //                   dotWidth: 15,
              //                   activeDotColor:
              //                       Color.fromARGB(255, 255, 111, 0)),
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   backgroundColor:
              //                       const Color.fromARGB(255, 255, 111, 0),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(20)),
              //                   minimumSize: const Size(300, 50)),
              //               onPressed: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (ctx) => const Maniscreen()));
              //               },
              //               child: const Text(
              //                 'Get Started',
              //                 style:
              //                     TextStyle(fontSize: 18, color: Colors.white),
              //               )),
              //           const SizedBox(
              //             height: 48,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
