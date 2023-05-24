import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Pizza extends SpriteComponent with CollisionCallbacks, HasGameRef {
  Pizza({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      cubit.eatPizza();
      removeFromParent();
      (gameRef as PullUpGame).hungerBar.restoreBar();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('pizza1.png');
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
