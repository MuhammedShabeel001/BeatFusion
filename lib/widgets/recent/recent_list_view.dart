import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class itemList extends StatelessWidget {
  const itemList({super.key});

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('Recently'), 
      builder: (context, box){
        var items = box.values.toList();

        if(items.isEmpty){
          return Center(
            child: Text('No items found'),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            var item = items[index];

            return ListTile(
              title: Text(item),
            );
          });
      });
  }
}