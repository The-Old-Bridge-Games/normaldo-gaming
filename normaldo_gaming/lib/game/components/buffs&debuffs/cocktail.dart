import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Cocktail extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Cocktail() : super(anchor: Anchor.center);

  late final _eatingHitbox = CircleHitbox(
    radius: size.x / 2.7,
    position: Vector2(2, size.y / 3 - 2),
  )..collisionType = CollisionType.passive;

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => CircleComponent(
        radius: size.x / 2,
        paint: auraPaint,
      );

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
      audio.playSfx(Sfx.cocktail);
      removeFromParent();
      (gameRef as PullUpGame).grid.changeSpeed(
          multiplier: 0.2,
          duration: Duration(seconds: Random().nextInt(4) + 2));
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('cocktail.png'),
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
  bool get isSoloSpawn => false;
}
