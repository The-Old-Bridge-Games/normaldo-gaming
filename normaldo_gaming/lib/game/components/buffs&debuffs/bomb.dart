import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Bomb extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Bomb({double speed = 0}) : super(anchor: Anchor.center) {
    this.speed = speed;
  }

  late final _eatingHitbox = CircleHitbox(
    radius: size.x / 2.7,
    position: Vector2(2, size.y / 3 - 2),
  )..collisionType = CollisionType.passive;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    speed = state.level.speed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      final grid = (gameRef as PullUpGame).grid;
      audio.playSfx(Sfx.bomb, customAssets: other.skin.assets.sfx['bomb']);
      Vibrate.vibrate();
      removeFromParent();
      grid.removeAllItems();
      grid.add(BombExplosionComponent()..size = grid.size);
    } else {
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('bomb.png'),
    ));
    add(_eatingHitbox);

    // 4DEV
    // add(CircleComponent(
    //   radius: size.x / 2.7,
    //   position: Vector2(2, size.y / 3 - 2),
    //   paint: Paint()..color = Colors.white.withOpacity(0.7),
    // ));

    return super.onLoad();
  }

  @override
  bool get isSoloSpawn => true;

  @override
  Items get item => Items.bomb;
}

class BombExplosionComponent extends PositionComponent {
  @override
  FutureOr<void> onLoad() {
    final screen = RectangleComponent(
      size: size,
      paint: Paint()..color = BasicPalette.white.color,
    )..opacity = 0;
    add(screen
      ..add(OpacityEffect.to(
          0.8,
          EffectController(
            duration: 0.2,
            reverseDuration: 0.2,
            curve: Curves.linearToEaseOut,
            onMin: () => screen.removeFromParent(),
          ))));
    return super.onLoad();
  }
}
