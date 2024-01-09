import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Homeless extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Homeless() : super(anchor: Anchor.center);

  final random = Random();

  late final _eatingHitbox = CircleHitbox(
    radius: size.x / 2.2,
    position: Vector2(2, 0),
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
    if (other is Normaldo && !other.immortal) {
      removeFromParent();
      if (other.skin.resistanceToItems.contains(item)) {
        audio.playCustomSfx(
          assets: other.skin.assets.sfx['resist']!,
          volume: 1.0,
        );
      } else {
        audio.playSfx(Sfx.binCrash);
        other.takeHit();
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    const duration = 0.3;
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    final start = 1 + random.nextInt(3).toDouble() + random.nextDouble();
    add(
      SpriteComponent(
        size: size,
        sprite: await Sprite.load(
            random.nextBool() ? 'homeless1.png' : 'homeless2.png'),
      ),
    );
    add(_eatingHitbox);
    add(
      TimerComponent(
          period: start,
          repeat: true,
          onTick: () {
            add(RotateEffect.to(
                pi * 2 * (random.nextBool() ? -1 : 1),
                EffectController(
                  duration: duration,
                  reverseDuration: duration,
                  // curve: Curves.easeInOutCubicEmphasized,
                  curve: Curves.easeInOutCubicEmphasized,
                )));
          }),
    );
    final grid = (gameRef as PullUpGame).grid;
    add(
      TimerComponent(
          period: start,
          repeat: true,
          onTick: () {
            add(MoveAlongPathEffect(
                Path()
                  ..quadraticBezierTo(-size.x / 2, -grid.lineSize, -size.x, 0),
                EffectController(
                  duration: duration,
                  reverseDuration: duration,
                )));
          }),
    );

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

  @override
  Items get item => Items.homeless;
}
