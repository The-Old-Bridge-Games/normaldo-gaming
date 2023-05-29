import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';

class PauseButton extends SpriteComponent
    with
        Tappable,
        FlameBlocReader<GameSessionCubit, GameSessionState>,
        HasGameRef,
        HasNgAudio {
  PauseButton() : super(size: Vector2(70, 70));
  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load('pause.png');

    await add(
      FlameBlocListener<GameSessionCubit, GameSessionState>(
          listenWhen: (previousState, newState) =>
              previousState.paused != newState.paused,
          onNewState: (state) {
            if (state.paused) {
              gameRef.pauseEngine();
              gameRef.overlays.add(Overlays.pauseMenu.name);
            } else {
              gameRef.resumeEngine();
              gameRef.overlays.remove(Overlays.pauseMenu.name);
            }
          }),
    );
  }

  @override
  bool onTapDown(TapDownInfo info) {
    audio.playSfx(Sfx.buttonPressed);
    bloc.togglePause();
    return true;
  }
}
