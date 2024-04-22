import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class Hourglass extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item, SlowMoItem {
  late final AudioPool _sfxPool;

  @override
  ShapeHitbox get hitbox => RectangleHitbox.relative(
        Vector2.all(0.9),
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.hourglass;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo) {
      _sfxPool.start();
      removeFromParent();
      slowMo();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('hourglass.png');
    _sfxPool = await AudioPool.createFromAsset(
      path: 'audio/sfx/magic_sound_longer.mp3',
      maxPlayers: 1,
    );
    add(RotateEffect.by(
        pi * 2,
        EffectController(
          infinite: true,
          speed: 5,
        )));
    return super.onLoad();
  }
}
