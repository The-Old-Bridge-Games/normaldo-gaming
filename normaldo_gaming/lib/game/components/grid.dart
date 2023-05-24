import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/trash_bin.dart';
import 'package:normaldo_gaming/game/components/items_creator.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

import 'normaldo.dart';

class Grid extends PositionComponent with Draggable, HasGameRef {
  static const linesCount = 5;

  Grid({required this.gameSessionCubit});

  final GameSessionCubit gameSessionCubit;

  late final Normaldo normaldo;
  late final ItemsCreator _itemsCreator;

  double _lineSize = 0;
  double get lineSize => _lineSize;

  final List<double> _linesCentersY = [];
  List<double> get linesCentersY => _linesCentersY;

  @override
  Future<void> onLoad() async {
    _lineSize = size.y / linesCount;
    normaldo = Normaldo(size: Vector2.all(lineSize * 0.9))
      ..position = Vector2(size.x / 2, size.y / 2)
      ..anchor = Anchor.center;
    for (int i = 1; i <= linesCount; i++) {
      _linesCentersY.add(_getCenterOfLine(i));
      add(RectangleComponent(
        position: Vector2(0, i * lineSize),
        size: Vector2(size.x, 1),
        paint: Paint()..color = BasicPalette.yellow.color,
      ));
    }
    await add(FlameBlocProvider<GameSessionCubit, GameSessionState>.value(
        value: gameSessionCubit,
        children: [
          _itemsCreator = ItemsCreator(grid: this),
          normaldo,
        ]));
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
    normaldo.position += info.delta.game;
    return super.onDragUpdate(info);
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
