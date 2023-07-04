import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';

class LevelTimerComponent extends TimerComponent
    with FlameBlocReader<LevelBloc, LevelState> {
  LevelTimerComponent() : super(period: 20, repeat: true);

  void _onTick() {
    if (bloc.state.figure != null) return;
    // bloc.add(
    //     const LevelEvent.startFigure(figure: FigureEvent.punchWave()));
    bloc.add(const LevelEvent.startRandomFigure());
    add(TimerComponent(
      period: (15 + Random().nextInt(16)).toDouble(),
      removeOnFinish: true,
      onTick: _onTick,
    ));
  }

  @override
  Future<void> onLoad() {
    add(TimerComponent(
      period: (15 + Random().nextInt(16)).toDouble(),
      removeOnFinish: true,
      onTick: _onTick,
    ));
    return super.onLoad();
  }

  @override
  void onTick() {
    bloc.add(LevelEvent.changeLevel(level: bloc.state.level.index + 1));
  }
}
