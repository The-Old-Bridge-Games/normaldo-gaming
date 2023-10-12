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
  static const int limitProgressingLevel = 50;
  static const double levelChangeDuration = 20;

  LevelBloc() : super(LevelState.initial()) {
    on<LevelEvent>((event, emit) => event.when(
        changeLevel: (levelIndex, effects) =>
            _onChangeLevel(levelIndex, effects, emit),
        startFigure: (figure) => _startFigure(figure, emit),
        changeSpeed: (multiplier, effects) =>
            _onChangeSpeed(multiplier, effects, emit),
        startRandomFigure: (_) => _startRandomFigure(emit),
        finishFigure: () => _onFigureFinished(emit)));
  }

  final _random = Random();
  List<FigureEvent> _figuresPool = [];

  double frequency(int level) {
    var frequency = pow(0.9, level + 1).toDouble();
    if (level > 15) {
      frequency = pow(0.9, 15).toDouble();
    }
    return frequency;
  }

  double speed(int level, List<Items> effects) {
    if (effects.contains(Items.hourglass)) {
      return state.level.speed;
    }
    var speed = (200 + (15 * level)).toDouble();
    if (level > limitProgressingLevel) {
      speed = (200 + (15 * 12)).toDouble();
    }
    return speed;
  }

  void _onChangeSpeed(
    double speed,
    List<Items> effects,
    Emitter<LevelState> emit,
  ) {
    final level = state.level.copyWith(speed: speed);
    emit(state.copyWith(level: level));
  }

  void _onChangeLevel(
    int level,
    List<Items> effects,
    Emitter<LevelState> emit,
  ) {
    emit(state.copyWith(
        level: LinearLevel(
      index: level,
      frequency: frequency(level),
      speed: speed(level, effects),
      itemsChances: _itemsAppearingByLevel[level] ?? state.level.itemsChances,
    )));
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
    if (_figuresPool.isEmpty) {
      _figuresPool = FigureEvent.values;
    }
    final figure = _figuresPool.removeAt(_random.nextInt(_figuresPool.length));
    emit(state.copyWith(figure: figure));
  }

  void _onFigureFinished(
    Emitter<LevelState> emit,
  ) {
    emit(state.copyWith(figure: null));
  }
}
