import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';

class TrashBin extends SpriteComponent with HasGameRef, CollisionCallbacks {
  TrashBin({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Normaldo) {
      if (cubit.state.hit) return;
      removeFromParent();
      await cubit.takeHit();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('trash_bin.png');
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    add(MoveEffect.to(
        Vector2(-size.x / 2, position.y),
        EffectController(
          duration: 3,
        )));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (position.x < -size.x / 2) {
      add(RemoveEffect());
    }
  }
}
