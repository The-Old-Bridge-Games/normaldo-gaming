import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';
import 'package:home_indicator/home_indicator.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/game/components/effects_component.dart';
import 'package:normaldo_gaming/game/components/fat_counter.dart';
import 'package:normaldo_gaming/game/components/pause_button.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';

import 'components/components.dart';
import 'components/grid.dart';

class PullUpGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection, HasNgAudio {
  PullUpGame({
    required this.gameSessionCubit,
    required this.levelBloc,
  });

  final GameSessionCubit gameSessionCubit;
  final LevelBloc levelBloc;

  // Components
  late final Scene scene;
  final scoreLabel = ScoreLabel();
  final balance = Balance();
  final pauseButton = PauseButton();
  final fatCounter = FatCounter();
  late final Grid grid;
  late final EffectsComponent effectsComponent;

  @override
  Future<void> onLoad() async {
    await HomeIndicator.hide();

    _initializeComponents();

    await _initBloc();

    return super.onLoad();
  }

  void _initializeComponents() {
    scene = Scene(initialSize: Vector2(size.x, size.x));
    scene.size = size;
    balance.position =
        Vector2(scoreLabel.x, scoreLabel.y + scoreLabel.size.y + 8);
    fatCounter.position.x = scoreLabel.x + 8;
    fatCounter.position.y = balance.position.y + balance.size.y + 16;
    fatCounter.size = Vector2(90, 20);
  }

  Future<void> _initBloc() async {
    gameSessionCubit.stream.listen((state) async {
      if (state.isDead) {
        await audio.stopBgm();
        pauseEngine();
        overlays.add(Overlays.deathScreen.name);
      }
    });

    await add(FlameBlocProvider<LevelBloc, LevelState>.value(
        value: levelBloc,
        children: [
          scene,
          grid = Grid(
            gameSessionCubit: gameSessionCubit,
            levelBloc: levelBloc,
          )
            ..size = Vector2(size.x, size.y)
            ..position = Vector2(0, 0),
          effectsComponent = EffectsComponent()
            ..position = Vector2(
                scoreLabel.x, fatCounter.position.y + fatCounter.size.y + 8),
        ]));
    await add(
      FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          RectangleComponent(
              size: Vector2(150, 100),
              paint: Paint()
                ..color = BasicPalette.black.color.withOpacity(0.5)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100)),
          scoreLabel,
          fatCounter,
          balance,
          pauseButton..position = Vector2(size.x - pauseButton.size.x - 32, 0),
        ],
      ),
    );
  }
}
