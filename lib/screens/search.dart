import 'package:beatfusion/common/text_style.dart';
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
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
          color: MyTheme().primaryColor, // Set background color to black
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ScreenHome()),
                        (route) => false,
                      );
                    },
                    icon: SvgPicture.asset('assets/pics/back.svg'),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyTheme().secondaryColor, // Set search box color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        cursorColor: MyTheme().secondaryColor,
                        controller: _searchController,
                        onChanged: (_) {
                          // Do something when the text changes
                        },
                        style: FontStyles.artist2, // Set text color to black
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          fillColor: MyTheme().secondaryColor,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Handle search icon tap
                            },
                            icon: SvgPicture.asset('assets/pics/search.svg'),
                          ),
                          // prefixIcon: IconButton(
                          //   onPressed: () {
                          //     // Handle search icon tap
                          //   },
                          //   icon: SvgPicture.asset('assets/pics/search.svg'),
                          // ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                
                child: Container(
                  // color: MyTheme().tertiaryColor,
                  padding: EdgeInsets.only( top: 10,bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                    color: MyTheme().secondaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(
                            item,
                            style: TextStyle(color: Colors.white), // Set text color to white
                          ),
                          // Do not require tapping to display the list
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
