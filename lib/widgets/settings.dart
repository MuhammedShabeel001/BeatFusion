import 'package:beatfusion/common/text_style.dart';
import 'package:beatfusion/widgets/privacy_policy.dart';
import 'package:beatfusion/widgets/rate_us.dart';
import 'package:beatfusion/widgets/terms_of_use.dart';
import 'package:flutter/material.dart';
import 'package:beatfusion/common/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});


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
          const SizedBox(height: 50,),
          Container(
            color: MyTheme().primaryColor,
            height:130,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/pics/BF.png',height: 56, width: 53,),
                Image.asset('assets/pics/BF-typo.png')
              ],
            ),
          ),
          Expanded(child: Container(
            padding: const EdgeInsets.only(bottom: 10,left: 10, right: 10),
            color: MyTheme().primaryColor,
            child: Container(
              decoration: BoxDecoration(
                color: MyTheme().secondaryColor,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  Expanded(child :SizedBox(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 15),
                          title: Text('Language',style: FontStyles.settings,),
                          subtitle: Text('English',style: FontStyles.settingsSub,),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 15),
                          title: Text('Rate us',style: FontStyles.settings,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const RateUsScreen()));
                          },
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 15),
                          title: Text('Privacy Policy',style: FontStyles.settings,),
                          onTap: () => showPrivacyPolicy(context)
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 15),
                          title: Text('Terms of use',style: FontStyles.settings,),
                          onTap: () => showTermOfUse(context)
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Version',style: FontStyles.name,),
                        Text(_version,style: FontStyles.artist,)
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
