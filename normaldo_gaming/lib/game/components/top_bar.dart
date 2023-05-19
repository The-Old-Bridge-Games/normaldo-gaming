import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class TopBar extends RectangleComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() {
    size = Vector2(game.size.x, 58);
    paint = Paint()..color = BasicPalette.black.color;
  }
}
