import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';

class Dumbbell extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocReader<GameSessionCubit, GameSessionState> {
  Dumbbell({double speed = 0}) : super(anchor: Anchor.center) {
    this.speed = speed;
  }

  late final _eatingHitbox = CircleHitbox(
    radius: size.x / 2.2,
    position: Vector2(2, 0),
  )..collisionType = CollisionType.passive;

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => CircleComponent()
    ..size = size
    ..paint = auraPaint;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      removeFromParent();
      audio.playSfx(Sfx.dumbbellCatch);
      other.decreaseFatPoints(20);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('dumbbell.png'),
    ));
    add(_eatingHitbox);

    // 4DEV
    // add(CircleComponent(
    //   radius: size.x / 2.2,
    //   position: Vector2(2, 0),
    //   paint: Paint()..color = Colors.white.withOpacity(0.7),
    // ));

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
  bool get isSoloSpawn => true;
}
