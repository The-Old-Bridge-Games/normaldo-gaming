import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

class Hourglass extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocReader<LevelBloc, LevelState>,
        FlameBlocListenable<LevelBloc, LevelState> {
  Hourglass() : super(anchor: Anchor.center);

  late final _eatingHitbox = RectangleHitbox(
    angle: pi * 1.61,
    anchor: Anchor.center,
    size: size * 0.8,
    position: Vector2(size.x / 2, size.y / 2),
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
      audio.playSfx(Sfx.hourglass);
      removeFromParent();
      other.effectsController
          .addEffect(item, Utils.generateHourglassDuration());
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
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
  bool get isSoloSpawn => true;

  @override
  Items get item => Items.hourglass;
}
