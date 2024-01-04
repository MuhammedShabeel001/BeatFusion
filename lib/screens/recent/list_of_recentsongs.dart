import 'package:beatfusion/screens/recent/recent_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListOfRecentSong extends StatelessWidget {
  const ListOfRecentSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent songs'),
      ),
      body: FutureBuilder(
        future: Hive.openBox('Recently'), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Center(
                child: Text('Error : ${snapshot.error}'),
              );
            }else{
              return itemList();
            }
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
    );
  }
}