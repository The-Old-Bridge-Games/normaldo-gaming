import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/game/components/fat_counter.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/hp_pizzas.dart';
import 'package:normaldo_gaming/game/components/pause_button.dart';
import 'package:normaldo_gaming/game/utils/overlays.dart';

import 'components/components.dart';
import 'components/grid.dart';

class PullUpGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection, HasNgAudio {
  PullUpGame({required this.gameSessionCubit});

  final GameSessionCubit gameSessionCubit;
  // Components
  late final Scene scene;
  final topBar = TopBar();
  final scoreLabel = ScoreLabel();
  final balance = Balance();
  final pauseButton = PauseButton();
  final hpPizzas = HpPizzas();
  final fatCounter = FatCounter();

  late final Grid grid;

  void removeAllItems() {
    removeWhere((component) => component is GameObject);
  }

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
    hpPizzas.position.x = size.x / 2 - hpPizzas.size.x - 16;
    hpPizzas.position.y = 12;
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

    await add(
      FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          scene,
          topBar,
          scoreLabel,
          hpPizzas,
          fatCounter,
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
