import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mini_games/mini_game.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class LevelTimerComponent extends TimerComponent
    with FlameBlocReader<LevelBloc, LevelState>, HasGameRef {
  LevelTimerComponent()
      : super(period: LevelBloc.levelChangeDuration, repeat: true);

  final random = Random();
  double get _eventPeriod => (15 + Random().nextInt(16)).toDouble();

  void _onTick() {
    if (bloc.state.miniGame != null) return;
    if (bloc.state.figure == null) {
      // bloc.add(const LevelEvent.startFigure(figure: FigureEvent.only2Lines()));
      bloc.add(const LevelEvent.startRandomFigure());
    }
    add(TimerComponent(
      period: _eventPeriod,
      removeOnFinish: true,
      onTick: _onTick,
    ));
  }

  @override
  Future<void> onLoad() {
    add(TimerComponent(
        // period: (80 + random.nextInt(40)).toDouble(),
        period: 30,
        repeat: true,
        removeOnFinish: true,
        onTick: () {
          if (random.nextBool()) {
            bloc.add(const LevelEvent.startMiniGame(game: MiniGame.shredder()));
          }
        }));
    add(TimerComponent(
      period: _eventPeriod,
      removeOnFinish: true,
      onTick: _onTick,
    ));
    return super.onLoad();
  }

  @override
  void onTick() {
    bloc.add(LevelEvent.changeLevel(
      level: bloc.state.level.index + 1,
      effects: (gameRef as PullUpGame)
          .grid
          .normaldo
          .effectsController
          .effectsInProgress,
    ));
  }
}
