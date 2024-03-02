import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/functions/control_functions.dart';
import 'package:beatfusion/screens/search.dart';
import 'package:beatfusion/screens/library.dart';
import 'package:beatfusion/widgets/Settings/settings.dart';
import 'package:beatfusion/widgets/Songs/list_of_songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> with SingleTickerProviderStateMixin {

  int currentSongID = 0;
  late TabController _tabController;
  Widget? permissionResult;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  defaultSongs(defaultsong){
    setState(() {
      search = defaultsong.data!;
    });
  } 

  bool isHome = true;
  bool isSearch = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyTheme().primaryColor,
      drawer: const SettingsScreen(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyTheme().appBarColor,
        title: Text(
          '${getTimeOfDay()},',
          style: FontStyles.greeting,
        ),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ScreenSearch(),));
             }, 
            icon: SvgPicture.asset('assets/pics/search.svg')),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
            }, 
            icon: Icon(Icons.settings_rounded,
            color: MyTheme().iconColor,))
        ],
        bottom: TabBar(
          dividerHeight: 0.0,
            splashFactory: NoSplash.splashFactory,
            controller: _tabController,            
            unselectedLabelColor: MyTheme().secondaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyTheme().secondaryColor),
          tabs: [
            Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyTheme().secondaryColor, width: 3)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Songs",
                    style: FontStyles.button,
                    ),
                ),
              ),
            ),
            Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MyTheme().secondaryColor, width: 3)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Library",
                    style: FontStyles.button,),
                ),
              ),
            ),
          ]),
      ),
      body:Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MyTheme().secondaryColor,
            borderRadius: BorderRadius.circular(12)
          ),
          child: TabBarView(
            controller: _tabController,
            children:  [
            const SongsList(),
            LibraryScreen()
          ],),
        ),
      ),
      );
  }
}