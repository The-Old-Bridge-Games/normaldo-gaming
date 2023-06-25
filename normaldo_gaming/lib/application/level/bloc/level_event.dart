part of 'level_bloc.dart';

@freezed
abstract class LevelEvent with _$LevelEvent {
  const factory LevelEvent.changeLevel({required int level}) = _ChangeLevel;
  const factory LevelEvent.changeSpeed({
    required int speed,
    required int seconds,
  }) = _ChangeSpeed;
  const factory LevelEvent.startFigure({
    required FigureEvent figure,
  }) = _StartFigure;
  const factory LevelEvent.startRandomFigure({
    List<FigureEvent>? figures,
  }) = _StartRandomFigure;
  const factory LevelEvent.finishFigure() = _FinishFigure;
}

@freezed
class FigureEvent with _$FigureEvent {
  const factory FigureEvent.trashWall() = _TrashWall;
  const factory FigureEvent.guardedPizza() = _GuardedPizza;
  const factory FigureEvent.cursedPath() = _CursedPath;

  static List<FigureEvent> get values => [
        const FigureEvent.trashWall(),
        const FigureEvent.guardedPizza(),
        const FigureEvent.cursedPath(),
      ];
}
