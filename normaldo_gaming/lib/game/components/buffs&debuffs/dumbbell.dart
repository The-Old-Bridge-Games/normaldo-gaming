import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Dumbbell extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Dumbbell() : super(anchor: Anchor.center);

  late final _eatingHitbox = CircleHitbox(
    radius: size.x / 2.2,
    position: Vector2(2, 0),
  )..collisionType = CollisionType.passive;

  @override
  Aura get aura => Aura.red;

  @override
  Component get auraComponent => CircleComponent()
    ..size = size
    ..paint = auraPaint;

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
      removeFromParent();
      audio.playSfx(Sfx.dumbbellCatch);
      other.decreaseFatPoints(Normaldo.pizzaToGetFatter);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(auraComponent);
    add(
      SpriteAnimationComponent(
          size: size,
          animation: SpriteAnimation.spriteList(
            [
              await Sprite.load('dumbbell1.png'),
              await Sprite.load('dumbbell2.png'),
            ],
            stepTime: 0.5,
          )),
    );
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
  bool get isSoloSpawn => true;
}
