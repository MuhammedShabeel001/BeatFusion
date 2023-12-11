import 'package:beatfusion/common/theme.dart';
import 'package:beatfusion/database/song.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  TextEditingController _searchController = TextEditingController();
  late Box<Song> songBox;
  List<Song> searchResults = [];

  @override
  void initState() {
    super.initState();
    songBox = Hive.box<Song>('songs');
  }

  List<Song> searchSongs(String query) {
    return songBox.values
        .where((song) =>
            song.name.toLowerCase().contains(query.toLowerCase()) ||
            song.artist.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void performSearch() {
    String query = _searchController.text.trim();
    List<Song> newSearchResults = searchSongs(query);

    setState(() {
      searchResults = newSearchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
          color: MyTheme().primaryColor,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyTheme().secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        cursorColor: MyTheme().secondaryColor,
                        controller: _searchController,
                        onChanged: (query) {
                          performSearch(); // Start searching while typing
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          fillColor: MyTheme().secondaryColor,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: performSearch,
                            icon: Icon(Icons.search, color: Colors.grey),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyTheme().secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: searchResults.isNotEmpty
                        ? ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final Song song = searchResults[index];
                              return ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  color: MyTheme().primaryColor,
                                ),
                                title: Text(
                                  song.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  song.artist,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No songs found.',
                              style: TextStyle(color: Colors.white),
                            ),
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
