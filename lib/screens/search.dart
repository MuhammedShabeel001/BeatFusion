import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          
          child: SearchAnchor(
            dividerColor: MyTheme().secondaryColor,
            viewSurfaceTintColor: MyTheme().secondaryColor,
            viewBackgroundColor: MyTheme().secondaryColor,
            builder: ( (context, controller) => SearchBar(
              controller: controller,
              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16)),
              onTap: (){
                controller.openView();
              },
              onChanged: (_){
                controller.openView();
              },
              trailing: [SvgPicture.asset('assets/pics/search.svg')],
              leading: IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ScreenHome(),), (route) => false);
            }, 
            icon: SvgPicture.asset('assets/pics/back.svg')),
            ) ), 
            suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );}
              
              );
          }),
        )
      );
      }
      }
  
