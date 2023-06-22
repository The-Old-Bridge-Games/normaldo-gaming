import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';

class TrashBin extends PositionComponent
    with
        HasGameRef,
        CollisionCallbacks,
        GameObject,
        FlameBlocReader<GameSessionCubit, GameSessionState> {
  TrashBin({double speed = 0}) : super(anchor: Anchor.center) {
    this.speed = speed;
  }

  @override
  Aura get aura => Aura.red;

  @override
  Component get auraComponent => RectangleComponent(
        size: size,
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo) {
      if (bloc.state.hit || bloc.state.isDead) return;
      removeFromParent();
      other.decreaseFatPoints(10);
      audio.playSfx(Sfx.binCrash);
      bloc.takeHit();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('trash_bin.png'),
    ));
    add(RectangleHitbox.relative(
      Vector2(0.9, 0.8),
      parentSize: size,
    ));
    // ..collisionType = CollisionType.passive);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= speed * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }

  @override
  bool get isSoloSpawn => false;
}
