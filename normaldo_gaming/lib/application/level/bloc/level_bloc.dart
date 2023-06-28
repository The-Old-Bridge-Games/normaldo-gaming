import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';

part 'level_bloc.freezed.dart';
part 'level_event.dart';
part 'level_state.dart';
part 'items_data.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  static const int limitProgressingLevel = 20;
  static const double levelChangeDuration = 20;

  LevelBloc() : super(LevelState.initial()) {
    on<LevelEvent>((event, emit) => event.when(
        changeLevel: (levelIndex) => _onChangeLevel(levelIndex, emit),
        changeSpeed: (speed, duration) => _onChangeSpeed(speed, duration, emit),
        startFigure: (figure) => _startFigure(figure, emit),
        startRandomFigure: (_) => _startRandomFigure(emit),
        finishFigure: () => _onFigureFinished(emit)));
  }

  var _forcedSpeedDuration = 0;

  bool get speedIsForced => _forcedSpeedDuration > 0;

  double frequency(int level) {
    var frequency = pow(0.9, level + 1).toDouble();
    if (level > limitProgressingLevel) {
      frequency = pow(0.9, limitProgressingLevel).toDouble();
    }
    return frequency;
  }

  double speed(int level) {
    var speed = (200 + (15 * level)).toDouble();
    if (level > limitProgressingLevel) {
      speed = (200 + (15 * 12)).toDouble();
    }
    if (_forcedSpeedDuration != 0) {
      return state.level.speed;
    }
    return speed;
  }

  void _onChangeLevel(
    int level,
    Emitter<LevelState> emit,
  ) {
    emit(state.copyWith(
        level: LinearLevel(
      index: level,
      frequency: frequency(level),
      speed: speed(level),
      itemsChances: _itemsAppearingByLevel[level] ?? state.level.itemsChances,
    )));
  }

  Future<void> _onChangeSpeed(
    int speed,
    int duration,
    Emitter<LevelState> emit,
  ) async {
    _forcedSpeedDuration += duration;
    emit(state.copyWith(
      level: state.level.copyWith(speed: speed.toDouble()),
    ));
    // just first initiation of temporary speed
    if (_forcedSpeedDuration == duration && _forcedSpeedDuration != 0) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        _forcedSpeedDuration--;
        if (_forcedSpeedDuration == 0) {
          add(LevelEvent.changeSpeed(
            speed: this.speed(state.level.index).toInt(),
            seconds: 0,
          ));
          timer.cancel();
        }
      });
    }
  }

  void _startFigure(
    FigureEvent figure,
    Emitter<LevelState> emit,
  ) {
    emit(
      state.copyWith(figure: figure),
    );
  }

  void _startRandomFigure(
    Emitter<LevelState> emit,
  ) {
    emit(state.copyWith(
      figure: FigureEvent.values[Random().nextInt(FigureEvent.values.length)],
    ));
  }

  void _onFigureFinished(
    Emitter<LevelState> emit,
  ) {
    emit(state.copyWith(figure: null));
  }
}
