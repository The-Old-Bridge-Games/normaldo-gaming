import 'package:flame/game.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'components/components.dart';

class PullUpGame extends FlameGame {
  PullUpGame({required this.gameSessionCubit});

  final GameSessionCubit gameSessionCubit;
  // Components
  final scene = Scene();
  final topBar = TopBar();
  final scoreLabel = ScoreLabel();
  final hungerBar = HungerBar();
  final balance = Balance();

  @override
  Future<void> onLoad() async {
    _configureComponents();

    await _initBloc();

    return super.onLoad();
  }

  void _configureComponents() {
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
        ],
      ),
    );
  }
}
