// // import 'package:beatfusion/database/song.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:just_audio/just_audio.dart';
// // import 'package:on_audio_query/on_audio_query.dart';

// // class SongService{
// //   final AudioPlayer _audioPlayer = AudioPlayer();
// //   late Box<Song> _songsBox;

// //   Future<void> init() async{
// //     await _audioPlayer.setAudioSource(
// //       ConcatenatingAudioSource(children: []),
// //       preload: true,
// //     );
// //     _songsBox = await Hive.openBox('songsBox');
// //   }

// //   Future<void> fetchAndStoreSongs() async {
// //     final songs = await OnAudioQuery().queryAudios();

// //     for (final songInfo in songs) {
// //       final song = Song(
// //         key: songInfo.id,
// //         name: songInfo.title,
// //         artist: songInfo.artist,
// //         duration: songInfo.duration,
// //         filePath: songInfo.filePath,
// //       );

// //       if (!_songsBox.values.contains(song)) {
// //         _songsBox.put(song.key, song);
// //       }
// //     }
// //   }

// //   Future<void> playSong(int key) async {
// //     final song = _songsBox.get(key);
// //     if (song != null) {
// //       await _audioPlayer.setAudioSource(
// //         AudioSource.uri(Uri.parse(song.filePath)),
// //         preload: true,
// //       );
// //       _audioPlayer.play();
// //     }
// //   }







// //   // Future<void> fetchSongs()async{
// //   //   final songsBox =  Hive.box<Song>('songsBox');
// //   //   final songs = await OnAudioQuery().queryAudios();

// //   //   for(final songInfo in songs){
// //   //     final song = Song(
// //   //       key: songInfo.id, 
// //   //       name: songInfo.title, 
// //   //       artist: songInfo.artist ?? 'unknown', 
// //   //       duration: songInfo.duration ?? 0, 
// //   //       filePath: songInfo.filePath
// //   //     );

// //   //     if(!songsBox.values.contains(song)){
// //   //       songsBox.put(song.key, song);
// //   //     }
// //   //   }
// //   // }
// // }



// import 'package:beatfusion/database/song.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:hive/hive.dart';
// // import 'song.dart';

// class SongService {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   late Box<Song> _songsBox;

//   Future<void> init() async {
//     await _audioPlayer.setAudioSource(
//       ConcatenatingAudioSource(children: []),
//       preload: true,
//     );
//     _songsBox = await Hive.openBox<Song>('songsBox');
//   }

//   Future<void> fetchAndStoreSongs() async {
//     final songs = await _audioQuery.querySongs();

//     for (final songInfo in songs) {
//       final song = Song(
//         key: songInfo.id,
//         name: songInfo.title ,
//         artist: songInfo.artist ?? 'unknown',
//         duration: songInfo.duration ?? 0,
//         filePath: songInfo.data ,
//       );

//       if (!_songsBox.values.contains(song)) {
//         _songsBox.put(song.key, song);
//       }
//     }
//   }

//   Future<void> playSong(int key) async {
//     final song = _songsBox.get(key);
//     if (song != null) {
//       await _audioPlayer.setAudioSource(
//         AudioSource.uri(Uri.parse(song.filePath)),
//         preload: true,
//       );
//       _audioPlayer.play();
//     }
//   }
// }




import 'package:beatfusion/database/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService{
  static late Box<Song> songBox;

  static Future<void> init()async{
    await Hive.initFlutter();
    Hive.registerAdapter(SongAdapter());
    songBox = await Hive.openBox<Song>('songs');
  }
}