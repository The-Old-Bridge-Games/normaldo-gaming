import 'package:normaldo_gaming/domain/app/sfx.dart';

final class NoAudio implements Exception {
  NoAudio(this.id);

  final int id;

  @override
  String toString() {
    return 'NoAudio with $id identifier';
  }
}

abstract class NgAudio {
  double get bgmVolume;
  double audioVolume({required int audioId});

  /// init audio pools and so on
  Future<void> init();

  /// paths to background audios
  List<String> get bgm;

  void addToBgm(String path);
  void addAllToBgm(List<String> paths);

  void removeFromBgm(String path);
  void removeAllFromBgm(List<String> paths);

  /// Starting to play audio from _bgm in order from first audio to the last.
  /// After last track starts again from the first audio.
  Future<void> playBgm();

  Future<void> pauseBgm();
  Future<void> resumeBgm();
  Future<void> stopBgm();
  void clearBgm();

  /// Plays audio and returns an identifier of audio player that
  /// handles this audio.
  Future<int> playAudio(String path, {double? volume});

  /// Loops an audio and returns an identifier of audio player that
  /// handles this audio.
  Future<int> loopAudio(String path, {double? volume});

  /// Pauses an audio player that handles audio with this identifier.
  Future<void> pause(int id);

  /// Resumes an audio player that handles audio with this identifier.
  Future<void> resume(int id);

  /// Stops an audio player that handles audio with this identifier.
  /// Deletes the audio player.
  Future<void> stopAudio(int id);

  /// Stops all audios created by playAudio
  Future<void> stopAllAudios();

  /// Pauses all audios created by playAudio
  Future<void> pauseAllAudios();

  /// Resumes all audios created by playAudio
  Future<void> resumeAllAudios();

  /// Plays sound effect. Cannot stop or pause it because in general sfx
  /// means that it will be a very short sound.
  Future<void> playSfx(
    Sfx sfx, {
    double? volume,
    List<String>? customAssets,
  });

  Future<void> setVolumeToBgm({required double volume});
  Future<void> setVolumeToAudio({
    required int audioId,
    required double volume,
  });
}
