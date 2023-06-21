import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/data/pull_up_game/level_controller.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';
import 'package:normaldo_gaming/game/components/level_iterator.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

import 'normaldo.dart';

class Grid extends PositionComponent with Draggable, HasGameRef {
  static const linesCount = 5;

  Grid({required this.gameSessionCubit});

  final GameSessionCubit gameSessionCubit;

  late final Normaldo normaldo;
  final _levelIterator = LevelIterator();
  final _levelController = LevelController();

  double _lineSize = 0;
  double get lineSize => _lineSize;

  double? _speedMultiplier;

  late Level currentLevel;

  final List<double> _linesCentersY = [];
  List<double> get linesCentersY => _linesCentersY;

  TimerComponent? _itemsCreator;

  void changeSpeed({
    required double multiplier,
    required Duration duration,
  }) {
    _speedMultiplier = multiplier;
    Future.delayed(duration).whenComplete(() {
      _speedMultiplier = null;
    });
  }

  @override
  Future<void> onLoad() async {
    _lineSize = size.y / linesCount;
    currentLevel = _levelController.linearLevel;
    normaldo = Normaldo(size: Vector2.all(lineSize * 0.9))
      ..position = Vector2(size.x / 2, size.y / 2);
    for (int i = 1; i <= linesCount; i++) {
      _linesCentersY.add(_getCenterOfLine(i));

      // 4DEV
      // add(RectangleComponent(
      //   position: Vector2(0, i * lineSize),
      //   size: Vector2(size.x, 1),
      //   paint: Paint()..color = BasicPalette.yellow.color,
      // ));
    }
    await add(FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          _levelIterator,
          normaldo,
          _itemsCreator = TimerComponent(
            period: currentLevel.frequency,
            repeat: true,
            onTick: () {
              gameRef.add(
                  FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
                      value: gameSessionCubit,
                      children: [
                    ...currentLevel.next().map((e) =>
                        e.item.component(speed: currentLevel.speed)
                          ..size = e.item.getSize(lineSize)
                          ..position = Vector2(
                              gameRef.size.x + e.item.getSize(lineSize).x * 2,
                              _linesCentersY[e.line ??
                                  Random().nextInt(_linesCentersY.length)]))
                  ]));
            },
          ),
        ]));

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        bloc: gameSessionCubit,
        listenWhen: (previousState, newState) =>
            previousState.level != newState.level,
        onNewState: (state) async {
          currentLevel = _levelController.changeLevel(state.level);
          await Future.delayed(Duration(
              seconds: Random()
                  .nextInt(LevelIterator.levelChangeSeconds.toInt() - 3)));
          currentLevel = _levelController.getRandomEvent(onFinish: () {
            currentLevel = _levelController.linearLevel;
          });
        }));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final rightSideX = normaldo.position.x + normaldo.size.x / 2;
    final bottomSideY = normaldo.position.y + normaldo.size.y / 2;
    final leftSideX = normaldo.position.x - normaldo.size.x / 2;
    final topSideY = normaldo.position.y - normaldo.size.x / 2;

    if (rightSideX > size.x) {
      normaldo.position.x = size.x - normaldo.size.x / 2;
    }
    if (bottomSideY > size.y) {
      normaldo.position.y = size.y - normaldo.size.y / 2;
    }
    if (leftSideX < 0) {
      normaldo.position.x = normaldo.size.x / 2;
    }
    if (topSideY < 0) {
      normaldo.position.y = normaldo.size.y / 2;
    }
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (_speedMultiplier != null) {
      normaldo.position += info.delta.game * _speedMultiplier!;
    } else {
      normaldo.position += info.delta.game * _getFatMultiplier(normaldo);
    }
    return super.onDragUpdate(info);
  }

  double _getFatMultiplier(Normaldo normaldo) {
    switch (normaldo.current) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.skinnyEat:
      case NormaldoFatState.skinnyDead:
        return 1;
      case NormaldoFatState.slim:
      case NormaldoFatState.slimEat:
      case NormaldoFatState.slimDead:
        return 0.7;
      case NormaldoFatState.fat:
      case NormaldoFatState.fatEat:
      case NormaldoFatState.fatDead:
        return 0.5;
      case NormaldoFatState.uberFat:
      case NormaldoFatState.uberFatEat:
      case NormaldoFatState.uberFatDead:
        return 0.4;
      case null:
        throw UnexpectedError();
    }
  }

  double _getCenterOfLine(int line) {
    int multiplier;
    switch (line) {
      case 1:
        multiplier = 1;
        break;
      case 2:
        multiplier = 3;
        break;
      case 3:
        multiplier = 5;
        break;
      case 4:
        multiplier = 7;
        break;
      case 5:
        multiplier = 9;
        break;
      default:
        throw UnexpectedError();
    }
    return (size.y / linesCount / 2 * multiplier +
        (gameRef as PullUpGame).topBar.height);
  }
}
