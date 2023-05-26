import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';

class BackgroundMusic extends PositionComponent
    with FlameBlocListenable<GameSessionCubit, GameSessionState> {
  final _random = Random();

  final _music = [
    'main_theme.mp3',
    'hard_track.mp3',
    'club_track.mp3',
  ];
  var _nextMusicIndex = 0;
  bool _randomizeTracks = false;
  AudioPlayer? _player;

  @override
  bool listenWhen(GameSessionState previousState, GameSessionState newState) {
    return previousState.paused != newState.paused || newState.isDead;
  }

  @override
  void onNewState(GameSessionState state) {
    if (state.isDead) {
      _player?.stop();
      return;
    }
    if (state.paused) {
      _player?.pause();
    } else {
      _player?.resume();
    }
  }

  @override
  FutureOr<void> onLoad() {
    _playBackground();
    return super.onLoad();
  }

  @override
  void onRemove() {
    _player?.stop();
    _player = null;
    super.onRemove();
  }

  Future<void> _playBackground() async {
    removeWhere((component) => component is TimerComponent);
    String nextMusic;
    if (!_randomizeTracks) {
      nextMusic = _music[_nextMusicIndex];
      if (_nextMusicIndex + 1 == _music.length) {
        _nextMusicIndex = 0;
      } else {
        if (_nextMusicIndex == _music.length - 1) {
          _randomizeTracks = true;
        }
        _nextMusicIndex++;
      }
    } else {
      nextMusic = _music[_random.nextInt(_music.length)];
    }
    print(nextMusic);
    _player = await FlameAudio.playLongAudio(nextMusic);
    final duration = await _player?.getDuration();
    print(duration);
    if (duration != null) {
      add(TimerComponent(
          period: duration.inSeconds.toDouble(),
          onTick: () {
            _playBackground();
          }));
    }
  }
}
