part of 'level_bloc.dart';

@freezed
abstract class LevelEvent with _$LevelEvent {
  const factory LevelEvent.changeLevel({required int level}) = _ChangeLevel;
  const factory LevelEvent.startFigure({
    required FigureEvent figure,
  }) = _StartFigure;
  const factory LevelEvent.startRandomFigure({
    List<FigureEvent>? figures,
  }) = _StartRandomFigure;
  const factory LevelEvent.finishFigure() = _FinishFigure;
  const factory LevelEvent.addEffect({
    required int timestamp,
    required Items item,
    required double duration,
  }) = _AddEffect;
  const factory LevelEvent.removeEffect({
    required Items item,
  }) = _RemoveEffect;
}

@freezed
class FigureEvent with _$FigureEvent {
  const factory FigureEvent.trashWall() = _TrashWall;
  const factory FigureEvent.guardedPizza() = _GuardedPizza;
  const factory FigureEvent.cursedPath() = _CursedPath;
  const factory FigureEvent.punchWave() = _PunchWave;
  const factory FigureEvent.bigBuddyBin() = _BigBuddyBin;
  const factory FigureEvent.unreachablePizza() = _UnreachablePizza;
  const factory FigureEvent.only2Lines() = _Only2Times;
  const factory FigureEvent.slowMo() = _SlowMo;

  static List<FigureEvent> get values => [
        const FigureEvent.trashWall(),
        const FigureEvent.guardedPizza(),
        const FigureEvent.cursedPath(),
        const FigureEvent.punchWave(),
        const FigureEvent.bigBuddyBin(),
        const FigureEvent.unreachablePizza(),
      ];
}
