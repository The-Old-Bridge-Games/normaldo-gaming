import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Hourglass extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocReader<GameSessionCubit, GameSessionState> {
  Hourglass({double speed = 0}) : super(anchor: Anchor.center) {
    this.speed = speed;
  }

  late final _eatingHitbox = RectangleHitbox(
    angle: pi * 1.61,
    anchor: Anchor.center,
    size: size * 0.8,
    position: Vector2(size.x / 2, size.y / 2),
  )..collisionType = CollisionType.passive;

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => CircleComponent(
        radius: size.x / 2,
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      audio.playSfx(Sfx.hourglass);
      removeFromParent();
      (gameRef as PullUpGame).changeItemsSpeed(
        speed: speed / 2,
        duration: Random().nextInt(8).toDouble() + 3,
      );
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('hourglass.png'),
    ));
    add(_eatingHitbox);
    add(RotateEffect.by(
        pi * 2,
        EffectController(
          infinite: true,
          speed: 5,
        )));

    // 4DEV
    // add(RectangleComponent(
    //   angle: pi * 1.61,
    //   anchor: Anchor.center,
    //   size: size * 0.8,
    //   position: Vector2(size.x / 2, size.y / 2),
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
