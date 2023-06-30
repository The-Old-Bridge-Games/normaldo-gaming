import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';

class LevelTimerComponent extends TimerComponent
    with FlameBlocReader<LevelBloc, LevelState> {
  LevelTimerComponent() : super(period: 20, repeat: true);

  @override
  Future<void> onLoad() {
    add(TimerComponent(
        period: 15,
        repeat: true,
        onTick: () {
          if (bloc.state.figure != null) return;
          final figureEvents = FigureEvent.values;
          // bloc.add(
          //     const LevelEvent.startFigure(figure: FigureEvent.guardedPizza()));
          bloc.add(LevelEvent.startFigure(
              figure: figureEvents[Random().nextInt(figureEvents.length)]));
        }));
    return super.onLoad();
  }

  @override
  void onTick() {
    bloc.add(LevelEvent.changeLevel(level: bloc.state.level.index + 1));
  }
}
