import 'dart:async';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';

class NoAudio implements Exception {
  NoAudio(this.id);

  final int id;

  @override
  String toString() {
    return 'NoAudio with $id identifier';
  }
}

class NgAudioImpl implements NgAudio {
  final _bgm = <String>[];
  String _currentBgmPath = '';
  AudioPlayer? _currentBgmPlayer;
  StreamSubscription<void>? _currentBgmStreamSub;

  final _players = <int, AudioPlayer>{};

  @override
  void addAllToBgm(List<String> paths) {
    _bgm.addAll(paths);
  }

  @override
  void addToBgm(String path) {
    _bgm.add(path);
  }

  @override
  List<String> get bgm => List.from(_bgm);

  @override
  Future<void> pause(int id) {
    if (!_players.containsKey(id)) {
      throw NoAudio(id);
    }
    return _players[id]!.pause();
  }

  @override
  Future<void> pauseBgm() async {
    await _currentBgmPlayer?.pause();
  }

  @override
  Future<int> playAudio(String path) async {
    final player = await FlameAudio.playLongAudio(path);
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
    if (_bgm.isEmpty) return;
    if (_currentBgmPath.isEmpty) {
      _currentBgmPath = _bgm.first;
    }
    await _currentBgmPlayer?.stop();
    _currentBgmStreamSub?.cancel();
    _currentBgmStreamSub = null;
    final player = await FlameAudio.playLongAudio(_currentBgmPath);
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
  Future<void> playSfx(Sfx sfx) async {
    await FlameAudio.play(sfx.paths[Random().nextInt(sfx.paths.length)]);
  }

  @override
  void removeAllFromBgm(List<String> paths) {
    for (var path in paths) {
      _bgm.remove(path);
    }
  }

  @override
  void removeFromBgm(String path) {
    _bgm.remove(path);
  }

  @override
  Future<void> resume(int id) {
    if (!_players.containsKey(id)) {
      throw NoAudio(id);
    }
    return _players[id]!.resume();
  }

  @override
  Future<void> resumeBgm() async {
    await _currentBgmPlayer?.resume();
  }

  @override
  Future<void> stopBgm() async {
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
    if (!_players.containsKey(id)) {
      throw NoAudio(id);
    }
    await _players[id]!.stop();
    _players.remove(id);
  }

  @override
  Future<int> loopAudio(String path) async {
    final player = await FlameAudio.loopLongAudio(path);
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
    _bgm.clear();
  }
}

extension on Sfx {
  List<String> get paths {
    switch (this) {
      case Sfx.eatPizza:
        return [
          'sfx/eaat.mp3',
          'sfx/eat_pizza.mp3',
        ];
      case Sfx.binCrash:
        return ['bla.mp3'];
      case Sfx.dollarCatch:
        return ['pizza_new_target.mp3'];
      case Sfx.eatFatPizza:
        return ['EAT_SUPER_PIZZA.mp3'];
      case Sfx.dumbbellCatch:
        return ['GANTELYA.mp3'];
      case Sfx.weightIncreased:
        return ['FATTNESS.mp3'];
      case Sfx.weightLoosed:
        return ['GANTELYA.mp3'];
      case Sfx.hurryUp:
        return ['HURRY_UP.mp3'];
      case Sfx.gameOver:
        return ['GAMEOVER.mp3'];
      case Sfx.buttonPressed:
        return ['BUTTON.mp3'];
    }
  }
}
