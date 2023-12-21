import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/widgets/rate_us.dart';
import 'package:flutter/material.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _version = 'Unknown';

  @override
  void initState(){
    super.initState();
    _getVersion();
  }

  Future <void> _getVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyTheme().primaryColor,
      child: Column(
        children: [
          SizedBox(height: 50,),
          Container(
            color: MyTheme().primaryColor,
            height:130,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset('assets/pics/BF.png',height: 56, width: 53,),
                Image.asset('assets/pics/BF-typo.png')
              ],
            ),
          ),
          Expanded(child: Container(
            padding: EdgeInsets.only(bottom: 10,left: 10, right: 10),
            color: MyTheme().primaryColor,
            child: Container(
              decoration: BoxDecoration(
                color: MyTheme().secondaryColor,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Container(
                    // color: Colors.deepPurple,
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text('Language',style: FontStyles.settings,),
                          subtitle: Text('English',style: FontStyles.settingsSub,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text('Rate us',style: FontStyles.settings,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RateUsScreen()));
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text('Privacy Policy',style: FontStyles.settings,),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text('Terms of use',style: FontStyles.settings,),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    // color: Colors.deepOrange,
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Version',style: FontStyles.name,),
                        Text('$_version',style: FontStyles.artist,)
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
