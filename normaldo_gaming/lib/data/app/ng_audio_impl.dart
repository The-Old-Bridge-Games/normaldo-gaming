import 'dart:async';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';

class NgAudioImpl implements NgAudio {
  double _bgmVolume = 0.1;

  final _bgm = <String>[];
  String _currentBgmPath = '';
  AudioPlayer? _currentBgmPlayer;
  StreamSubscription<void>? _currentBgmStreamSub;

  final _players = <int, AudioPlayer>{};

  final Map<Sfx, List<AudioPool>> _audioPools = {};

  bool _initialized = false;

  @override
  Future<void> init() async {
    _initialized = true;
  }

  @override
  void addAllToBgm(List<String> paths) {
    assert(_initialized);
    _bgm.addAll(paths);
  }

  @override
  void addToBgm(String path) {
    assert(_initialized);
    _bgm.add(path);
  }

  @override
  List<String> get bgm => List.from(_bgm);

  @override
  Future<void> pause(int id) {
    assert(_initialized);
    if (!_players.containsKey(id)) {
      throw NoAudio(id);
    }
    return _players[id]!.pause();
  }

  @override
  Future<void> pauseBgm() async {
    assert(_initialized);
    await _currentBgmPlayer?.pause();
  }

  @override
  Future<int> playAudio(String path, {double? volume}) async {
    assert(_initialized);
    final player =
        await FlameAudio.playLongAudio(path, volume: volume ?? _bgmVolume);
    int id;
    if (_players.entries.isNotEmpty) {
      id = _players.entries.last.key + 1;
      _players[id] = player;
    } else {
      id = 0;
      _players[id] = player;
    }
    return id;
  }

  @override
  Future<void> playBgm() async {
    assert(_initialized);
    if (_bgm.isEmpty) return;
    if (_currentBgmPath.isEmpty) {
      _currentBgmPath = _bgm.first;
    }
    await _currentBgmPlayer?.stop();
    _currentBgmStreamSub?.cancel();
    _currentBgmStreamSub = null;
    final player =
        await FlameAudio.playLongAudio(_currentBgmPath, volume: _bgmVolume);
    _currentBgmPlayer = player;
    final nextIndex = _bgm.indexOf(_currentBgmPath) + 1;
    if (nextIndex < _bgm.length) {
      _currentBgmPath = _bgm[nextIndex];
    } else {
      _currentBgmPath = _bgm.first;
    }
    _currentBgmStreamSub = player.onPlayerComplete.listen((_) {
      playBgm();
    });
  }

  @override
  Future<void> playSfx(
    Sfx sfx, {
    double? volume,
    List<String>? customAssets,
  }) async {
    assert(_initialized);
    try {
      if (sfx == Sfx.buttonPressed) {
        Vibrate.feedback(FeedbackType.light);
      }
      if (customAssets != null && customAssets.isNotEmpty) {
        await _playCustomSfx(assets: customAssets, volume: volume);
        return;
      }
      final pools = _audioPools[sfx] ?? [];
      await pools[Random().nextInt(pools.length)].start(volume: volume ?? 1.0);
    } catch (e) {
      print(e);
    }
  }

  @override
  void removeAllFromBgm(List<String> paths) {
    assert(_initialized);
    for (var path in paths) {
      _bgm.remove(path);
    }
  }

  @override
  void removeFromBgm(String path) {
    assert(_initialized);
    _bgm.remove(path);
  }

  @override
  Future<void> resume(int id) {
    assert(_initialized);
    if (!_players.containsKey(id)) {
      throw NoAudio(id);
    }
    return _players[id]!.resume();
  }

  @override
  Future<void> resumeBgm() async {
    assert(_initialized);
    await _currentBgmPlayer?.resume();
  }

  @override
  Future<void> stopBgm() async {
    assert(_initialized);
    if (_currentBgmPlayer != null) {
      await _currentBgmPlayer?.stop();
      _currentBgmPlayer = null;
      _currentBgmStreamSub?.cancel();
      _currentBgmStreamSub = null;
      _currentBgmPath = _bgm.first;
    }
  }

  @override
  Future<void> stopAudio(int id) async {
    assert(_initialized);
    if (!_players.containsKey(id)) {
      throw NoAudio(id);
    }
    await _players[id]!.stop();
    _players.remove(id);
  }

  @override
  Future<int> loopAudio(String path, {double? volume}) async {
    assert(_initialized);
    final player =
        await FlameAudio.loopLongAudio(path, volume: volume ?? _bgmVolume);
    int id;
    if (_players.entries.isNotEmpty) {
      id = _players.entries.last.key + 1;
      _players[id] = player;
    } else {
      id = 0;
      _players[id] = player;
    }
    return id;
  }

  @override
  void clearBgm() {
    assert(_initialized);
    _bgm.clear();
  }

  @override
  Future<void> setVolumeToAudio({
    required int audioId,
    required double volume,
  }) async {
    if (volume < 0 || volume > 1) return;
    final player = _players[audioId];
    if (player != null) {
      return player.setVolume(volume);
    }
  }

  @override
  Future<void> setVolumeToBgm({required double volume}) async {
    if (volume < 0 || volume > 1) return;
    _bgmVolume = volume;
    await _currentBgmPlayer?.setVolume(volume);
  }

  @override
  double audioVolume({required int audioId}) {
    final player = _players[audioId];
    if (player != null) return player.volume;
    throw NoAudio(audioId);
  }

  @override
  double get bgmVolume => _currentBgmPlayer?.volume ?? _bgmVolume;

  @override
  Future<void> stopAllAudios() async {
    for (final player in _players.values) {
      await player.stop();
    }
    _players.clear();
  }

  @override
  Future<void> pauseAllAudios() async {
    for (final player in _players.values) {
      await player.pause();
    }
  }

  @override
  Future<void> resumeAllAudios() async {
    for (final player in _players.values) {
      await player.resume();
    }
  }

  Future<void> _playCustomSfx({
    required List<String> assets,
    double? volume,
  }) async {
    assert(assets.isNotEmpty);
    await FlameAudio.play(
      'skins/${assets[Random().nextInt(assets.length)]}',
      volume: volume ?? 1.0,
    );
  }
}

extension on Sfx {
  List<String> get paths {
    switch (this) {
      case Sfx.eatPizza:
        return [
          'havaet.mp3',
          'havaet2.mp3',
        ];
      case Sfx.binCrash:
        return ['ydar.mp3'];
      case Sfx.dollarCatch:
        return ['dollars.mp3'];
      case Sfx.eatFatPizza:
        return ['super_pizza.mp3'];
      case Sfx.dumbbellCatch:
        return ['gantelya1.mp3'];
      case Sfx.weightIncreased:
        return ['eeeeee.mp3'];
      case Sfx.weightLoosed:
        return ['death.mp3'];
      case Sfx.gameOver:
        return ['game_over.mp3'];
      case Sfx.buttonPressed:
        return ['button1.mp3'];
      case Sfx.bomb:
        return ['bomb1.mp3'];
      case Sfx.cocktail:
        return ['super_pizza.mp3'];
      case Sfx.molotov:
        return ['molotov1.mp3'];
      case Sfx.hourglass:
        return ['magic_sound_longer.mp3'];
      case Sfx.roundBox:
        return ['round_box.mp3'];
      case Sfx.missionCompleted:
        return ['mission_notification.mp3'];
      case Sfx.shredderPredator:
        return ['shredder_predator.mp3'];
      case Sfx.shurikens:
        return ['shurikens.mp3'];
      case Sfx.rollDropped:
        return ['roll_dropped.mp3'];
      case Sfx.spin:
        return ['spin.mp3'];
    }
  }

  int get maxPlayers => switch (this) {
        Sfx.eatPizza => 15,
        Sfx.binCrash => 3,
        Sfx.dollarCatch => 5,
        Sfx.eatFatPizza => 1,
        Sfx.dumbbellCatch => 3,
        Sfx.weightIncreased => 1,
        Sfx.weightLoosed => 1,
        Sfx.gameOver => 1,
        Sfx.buttonPressed => 2,
        Sfx.bomb => 1,
        Sfx.cocktail => 5,
        Sfx.molotov => 10,
        Sfx.hourglass => 5,
        Sfx.roundBox => 8,
        Sfx.missionCompleted => 2,
        Sfx.shredderPredator => 5,
        Sfx.shurikens => 4,
        Sfx.rollDropped => 1,
        Sfx.spin => 1,
      };
}
