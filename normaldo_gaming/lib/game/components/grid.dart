import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';

import 'normaldo.dart';

class Grid extends PositionComponent with Draggable {
  late final Normaldo normaldo;

  double _lineSize = 0;
  double get lineSize => _lineSize;

  @override
  FutureOr<void> onLoad() {
    const lines = 5;
    _lineSize = size.y / lines;
    normaldo = Normaldo(size: Vector2.all(lineSize))
      ..position = Vector2(size.x / 2, size.y / 2)
      ..anchor = Anchor.center;
    for (int i = 1; i < 5; i++) {
      add(RectangleComponent(
        position: Vector2(0, i * lineSize),
        size: Vector2(size.x, 1),
        paint: Paint()..color = BasicPalette.yellow.color,
      ));
    }
    add(ScreenHitbox()..size = size);
    add(normaldo);
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
}
