import 'dart:async';
import 'package:flame/game.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/game/components/pause_button.dart';

import 'components/components.dart';
import 'components/grid.dart';

class PullUpGame extends FlameGame with HasTappables, HasDraggables {
  PullUpGame({required this.gameSessionCubit});

  final GameSessionCubit gameSessionCubit;
  // Components
  final scene = Scene();
  final topBar = TopBar();
  final scoreLabel = ScoreLabel();
  final hungerBar = HungerBar();
  final balance = Balance();
  final pauseButton = PauseButton();
  final grid = Grid();

  @override
  Future<void> onLoad() async {
    _initializeComponents();

    await _initBloc();

    return super.onLoad();
  }

  void _initializeComponents() {
    scene.size = size;
    balance.position = Vector2(48 + scoreLabel.size.x + 96, scoreLabel.y);
    hungerBar.position = Vector2(
        48 + scoreLabel.size.x + 96 + balance.size.x + 148, scoreLabel.y);
  }

  Future<void> _initBloc() async {
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
          grid
            ..size = Vector2(size.x, size.y - topBar.height)
            ..position = Vector2(0, topBar.height),
        ],
      ),
    );
  }
}
