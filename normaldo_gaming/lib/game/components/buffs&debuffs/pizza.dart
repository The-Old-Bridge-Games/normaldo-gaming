import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Pizza extends SpriteComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        Eatable,
        HasNgAudio {
  Pizza({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  final _eatingHitbox = RectangleHitbox()
    ..collisionType = CollisionType.passive;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      cubit.eatPizza();
      audio.playSfx(Sfx.eatPizza);
      removeFromParent();
      (gameRef as PullUpGame).hungerBar.restoreBar();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('pizza1.png');
    add(_eatingHitbox..anchor = anchor);

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
