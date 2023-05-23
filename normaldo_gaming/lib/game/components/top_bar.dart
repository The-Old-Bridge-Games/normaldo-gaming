import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class TopBar extends RectangleComponent with HasGameRef {
  final double height = 58;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(game.size.x, height);
    paint = Paint()..color = BasicPalette.black.color;
  }
}
