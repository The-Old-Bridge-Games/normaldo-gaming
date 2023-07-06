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
        changeLevel: (levelIndex) => _onChangeLevel(levelIndex, emit),
        addEffect: (timestamp, item, duration) =>
            _onAddEffect(timestamp, item, duration, emit),
        removeEffect: (item) => _onRemoveEffect(item, emit),
        startFigure: (figure) => _startFigure(figure, emit),
        startRandomFigure: (_) => _startRandomFigure(emit),
        finishFigure: () => _onFigureFinished(emit)));
  }

  double frequency(int level) {
    var frequency = pow(0.9, level + 1).toDouble();
    if (level > 15) {
      frequency = pow(0.9, 15).toDouble();
    }
    return frequency;
  }

  double speed(int level) {
    var speed = (200 + (15 * level)).toDouble();
    if (level > limitProgressingLevel) {
      speed = (200 + (15 * 12)).toDouble();
    }
    if (state.effects.values
        .where((element) => element.key == Items.hourglass)
        .isNotEmpty) {
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

  void _onAddEffect(
    int timestamp,
    Items item,
    double duration,
    Emitter<LevelState> emit,
  ) async {
    final effects = Map<int, MapEntry<Items, double>>.from(state.effects);
    final same = effects.entries.where((entry) => entry.value.key == item);
    final List<int> toRemove = [];
    for (final entry in same) {
      toRemove.add(entry.key);
    }
    for (final removeKey in toRemove) {
      effects.remove(removeKey);
    }
    var newState = state.copyWith(
        effects: effects..[timestamp] = MapEntry(item, duration));

    if (item == Items.hourglass &&
        state.effects.values
            .where((element) => element.key == Items.hourglass)
            .isEmpty) {
      newState = newState.copyWith(
        level: state.level.copyWith(speed: state.level.speed / 2),
      );
    }

    emit(newState);
  }

  void _onRemoveEffect(
    Items item,
    Emitter<LevelState> emit,
  ) {
    final effects = Map<int, MapEntry<Items, double>>.from(state.effects);
    final int? removeKey = effects.entries
        .cast()
        .firstWhere((element) => element.value.key == item, orElse: () => null)
        ?.key;
    var newState = state.copyWith(effects: effects..remove(removeKey));

    emit(newState);

    if (item == Items.hourglass) {
      emit(newState.copyWith(
          level: state.level.copyWith(speed: speed(state.level.index))));
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
