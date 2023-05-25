import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Pizza extends SpriteComponent
    with CollisionCallbacks, HasGameRef, HasLevelConfigurator {
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

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= levelConfigurator.itemSpeed(cubit.state.level) * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }
}
