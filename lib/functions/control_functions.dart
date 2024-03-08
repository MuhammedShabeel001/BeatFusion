import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DurationState{
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}

List<SongModel> songs = [];
List<SongModel> search = [];
List <SongModel> filteredSongs = [];

String currentSongTitle = '';
String? currentArtist = '';
int currentIndex = 0;
int currrentSongID = 0;

bool isPlayerViewVisible = false;

bool isShuffle = false;
bool isFavorite = false;

bool isPlaying = false;

bool isMusicPlayerTapped = true;



String searchResult = '';

final List<SongSortType> sortTechnique = [
  SongSortType.TITLE,
  SongSortType.ARTIST,
  SongSortType.DATE_ADDED,
  SongSortType.ALBUM
];

final List<OrderType> orderTechnique = [
  OrderType.ASC_OR_SMALLER,
  OrderType.DESC_OR_GREATER
];

ConcatenatingAudioSource createPlaylist(List<SongModel>? songs){
    List<AudioSource> sources = [];

    for(var song in songs!){
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }

    return ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: sources);
}

String getTimeOfDay() {
  var now = DateTime.now();
  var time = now.hour;

  if (time < 12) {
    return 'Good morning';
  } else if (time < 16) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
