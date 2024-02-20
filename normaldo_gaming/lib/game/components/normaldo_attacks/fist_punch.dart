import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/boss_hp.dart';
import 'package:normaldo_gaming/game/components/effects/effects.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class FistPunch extends SpriteComponent
    with
        CollisionCallbacks,
        HasGameRef<PullUpGame>,
        Item,
        NormaldoAttack,
        Effects {
  @override
  PositionComponent get hitbox => CircleHitbox.relative(
        0.8,
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.fistPunch;

  @override
  bool get moving => false;

  late Sprite _fistSprite;

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      removeFromParent();
      attack(
          game.grid.children.firstWhere((element) => element is Boss) as Boss);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    paint = Paint()..color = Colors.red;
    _fistSprite = await Sprite.load('bosses/ninja_foot_fist.png');
    sprite = await Sprite.load('slakebake.png');
    return super.onLoad();
  }

  @override
  void attack(Boss boss) {
    final normaldo = game.grid.normaldo;
    boss.pauseAttack();
    game.grid.removeAllItems();
    game.camera.moveTo(
      boss.position - Vector2(boss.size.x * 2, 0),
      speed: 1000,
    );
    game.camera.viewfinder.add(ScaleEffect.to(
      Vector2.all(2),
      EffectController(
        duration: 0.1,
      ),
    ));
    game.grid.controlTurnedOff = true;
    normaldo.add(
      MoveToEffect(
          boss.position - Vector2(boss.size.x * 2, 0),
          EffectController(
            duration: 0.3,
          )),
    );
    final fist = SpriteComponent(
        sprite: _fistSprite,
        size: Vector2.all(game.grid.lineSize * 1.5),
        scale: Vector2.all(0.2),
        anchor: Anchor.centerLeft,
        angle: -0.5);
    const double atMaxDelay = 0.5;
    normaldo.add(fist
      ..position = normaldo.size / 2
      ..add(SequenceEffect(
        [
          MoveByEffect(
              Vector2(normaldo.size.x / 2, -normaldo.size.y / 3),
              EffectController(
                duration: 0.1,
                startDelay: 0.5,
              ), onComplete: () {
            fist.addAll([
              MoveByEffect(
                  Vector2(30, 80),
                  EffectController(
                    duration: 0.5,
                  )),
            ]);
            fist.add(RotateEffect.to(
                0.1,
                EffectController(
                  duration: 0.1,
                )));
            normaldo.add(RotateEffect.by(
                0.2,
                EffectController(
                  duration: 0.1,
                  reverseDuration: 0.1,
                )));
            boss.add(fadeOutEffect(duration: 0.3));
            boss.stopAttack();
            boss.hp--;
            (gameRef.camera.viewfinder.children
                    .firstWhere((element) => element is BossHp) as BossHp)
                .decrease();
            if (boss.hp <= 0) {
              boss.die();
            }
          }),
          ScaleEffect.to(
              Vector2.all(1),
              EffectController(
                duration: 0.2,
                reverseDuration: 0.2,
                atMaxDuration: atMaxDelay,
              ), onComplete: () {
            game.grid.controlTurnedOff = false;
            game.camera.moveTo(game.grid.center, speed: 500);
            normaldo.addAll(jumpToEffect(
                position: Vector2(normaldo.size.x * 2, game.size.y / 2)));
            game.camera.viewfinder.add(ScaleEffect.to(
              Vector2.all(1),
              EffectController(
                duration: 0.3,
              ),
            ));
          }),
        ],
        onComplete: () => fist.removeFromParent(),
      )));
  }
}
