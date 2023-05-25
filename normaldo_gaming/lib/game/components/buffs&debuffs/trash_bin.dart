import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_configurator.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class TrashBin extends SpriteComponent with HasGameRef, CollisionCallbacks {
  TrashBin({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;
  final _levelConfigurator = injector.get<LevelConfigurator>();

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

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= _levelConfigurator.itemSpeed(cubit.state.level) * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }
}
