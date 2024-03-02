import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DatabaseHelper {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<bool> requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
        return await _audioQuery.permissionsStatus();
      }
    }
    return true;
  }
}