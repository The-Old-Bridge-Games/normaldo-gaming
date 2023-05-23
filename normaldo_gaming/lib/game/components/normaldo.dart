import 'dart:async';

import 'package:flame/components.dart';

class Normaldo extends SpriteComponent {
  Normaldo({
    required Vector2 size,
  }) : super(size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('normaldo1.png');
  }
}
