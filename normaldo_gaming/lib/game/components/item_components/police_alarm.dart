import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class PoliceAlarm extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item, AttackingItem {
  @override
  int get damage => 1;

  @override
  ShapeHitbox get hitbox => CircleHitbox.relative(
        0.9,
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.policeAlarm;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    attack(other);
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    strength = 1;
    sprite = await Sprite.load('knopka siren1 3.png');
    return super.onLoad();
  }
}
