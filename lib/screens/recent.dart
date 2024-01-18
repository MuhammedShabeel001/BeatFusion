import 'package:beatfusion/database/history.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:your_project_name/database/history.dart';

class RecentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Songs'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<SongHistory>('history'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var historyBox = Hive.box<SongHistory>('history');
            var recentSongs = historyBox.get(0)?.RecentSong ?? [];

            return ListView.builder(
              itemCount: recentSongs.length,
              itemBuilder: (context, index) {
                var song = recentSongs[index];
                return ListTile(
                  title: Text(song.name),
                  subtitle: Text(song.artist),
                  // Add more UI components as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
