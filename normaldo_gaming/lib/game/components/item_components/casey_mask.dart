import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class CaseyMask extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item, ImmuneItem {
  late final AudioPool _sfxPool;

  @override
  ShapeHitbox get hitbox => CircleHitbox.relative(
        0.9,
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.caseyMask;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      _sfxPool.start();
      immuneTo<AttackingItem>();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('kasey mask2 2.png');
    _sfxPool = await AudioPool.createFromAsset(
      path: 'audio/sfx/MASK FLY AROUND.mp3',
      maxPlayers: 1,
    );
    return super.onLoad();
  }
}
