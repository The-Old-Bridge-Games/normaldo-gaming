part of 'level_bloc.dart';

@freezed
class LevelState with _$LevelState {
  const factory LevelState({
    required LinearLevel level,

    /// timestamp => (item => duration)
    required Map<int, MapEntry<Items, double>> effects,
    FigureEvent? figure,
  }) = _LevelState;

  factory LevelState.initial() => LevelState(
      effects: {},
      level: LinearLevel(
        index: 0,
        frequency: 0.5,
        speed: 200,
        itemsChances: _itemsAppearingByLevel[0]!,
      ));
}
