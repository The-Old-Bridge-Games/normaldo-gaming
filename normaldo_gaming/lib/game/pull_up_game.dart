import 'dart:async';
import 'package:flame/game.dart';
import 'package:home_indicator/home_indicator.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
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
  final topBar = TopBar();
  final scoreLabel = ScoreLabel();
  final balance = Balance();
  final pauseButton = PauseButton();
  final fatCounter = FatCounter();
  late final Grid grid;

  @override
  Future<void> onLoad() async {
    await HomeIndicator.hide();

    _initializeComponents();

    await _initBloc();

    return super.onLoad();
  }

  void _initializeComponents() {
    scene = Scene(initialSize: Vector2(size.x, size.x - topBar.height));
    scene.size = size;
    balance.position = Vector2(48 + scoreLabel.size.x + 144, scoreLabel.y);
    fatCounter.position.x = size.x / 2 + 40;
    fatCounter.position.y = 12;
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
            ..size = Vector2(size.x, size.y - topBar.height)
            ..position = Vector2(0, topBar.height),
        ]));
    await add(
      FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          topBar,
          scoreLabel,
          fatCounter,
          balance,
          pauseButton..position = Vector2(size.x - pauseButton.size.x - 32, -8),
        ],
      ),
    );
  }
}
