import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/game/components/pause_button.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';

import 'components/components.dart';
import 'components/grid.dart';

class PullUpGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection {
  PullUpGame({required this.gameSessionCubit});

  final GameSessionCubit gameSessionCubit;
  // Components
  late final Scene scene;
  final topBar = TopBar();
  final scoreLabel = ScoreLabel();
  final hungerBar = HungerBar();
  final balance = Balance();
  final pauseButton = PauseButton();

  late final Grid grid;

  @override
  Future<void> onLoad() async {
    _initializeComponents();

    await _initBloc();

    return super.onLoad();
  }

  void _initializeComponents() {
    scene = Scene(initialSize: size);
    scene.size = size;
    balance.position = Vector2(48 + scoreLabel.size.x + 144, scoreLabel.y);
    hungerBar.position = Vector2(
        48 + scoreLabel.size.x + 96 + balance.size.x + 148, scoreLabel.y);
  }

  Future<void> _initBloc() async {
    gameSessionCubit.stream.listen((state) {
      if (state.isDead) {
        pauseEngine();
        overlays.add(Overlays.deathScreen.name);
      }
    });

    await add(
      FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          scene,
          topBar,
          scoreLabel,
          hungerBar,
          balance,
          pauseButton..position = Vector2(size.x - pauseButton.size.x - 32, -8),
          grid = Grid(gameSessionCubit: gameSessionCubit)
            ..size = Vector2(size.x, size.y - topBar.height)
            ..position = Vector2(0, topBar.height),

          // 4DEV
          // LevelLabel()..position = Vector2(size.x / 2 - 100, 16),
        ],
      ),
    );
  }
}

class LevelLabel extends TextComponent {
  LevelLabel();

  @override
  FutureOr<void> onLoad() async {
    text = 'Level 1';

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
      listenWhen: (previousState, newState) =>
          previousState.level != newState.level,
      onNewState: (state) {
        text = 'Level ${state.level + 1}';
      },
    ));
  }
}
