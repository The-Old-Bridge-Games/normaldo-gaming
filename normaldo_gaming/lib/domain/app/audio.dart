import 'package:normaldo_gaming/domain/app/sfx.dart';

abstract class NgAudio {
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

  /// Plays sound effect. Cannot stop or pause it because in general sfx
  /// means that it will be a very short sound.
  Future<void> playSfx(Sfx sfx);
}
