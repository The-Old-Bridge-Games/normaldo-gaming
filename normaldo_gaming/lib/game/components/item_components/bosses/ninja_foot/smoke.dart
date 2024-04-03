import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/attacks/shuriken_shower_attack.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Smoke extends PositionComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item {
  final List<Corner> corners;

  Smoke({required this.corners});

  @override
  PositionComponent get hitbox => RectangleComponent();

  @override
  Items get item => Items.smoke;

  @override
  bool get moving => false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    final smokeProjectileSprite =
        await Sprite.load('bosses/smoke_projectile.png');
    final smokeSprite = await Sprite.load('bosses/smoke.png');
    add(SpriteComponent(
      sprite: await Sprite.load('bosses/smoke_projectile.png'),
      size: size,
    ));
    add(
      MoveToEffect(gameRef.grid.center, EffectController(duration: 0.1),
          onComplete: () {
        removeWhere((component) => component is SpriteComponent);
        for (final corner in corners) {
          final spriteComp = SpriteComponent(
            sprite: smokeProjectileSprite,
            size: size,
            anchor: Anchor.center,
            position: gameRef.grid.center,
            paint: Paint()..color = Colors.yellow,
          );
          gameRef.grid.add(spriteComp
            ..add(MoveToEffect(
              corner.position,
              EffectController(duration: 0.5),
              onComplete: () {
                spriteComp.removeFromParent();
                final smokeComp = SpriteComponent(
                  sprite: smokeSprite,
                  anchor: Anchor.center,
                  size: Vector2(
                      gameRef.grid.lineSize * 2, gameRef.grid.lineSize * 1.5),
                  position: corner.position,
                  priority: 10,
                );
                gameRef.grid.add(smokeComp
                  ..addAll([
                    ScaleEffect.to(
                        Vector2.all(1.2),
                        EffectController(
                          duration: 0.5,
                          reverseDuration: 0.5,
                          infinite: true,
                        )),
                    TimerComponent(
                        period: Random().nextDouble() * 10 + 0.5,
                        repeat: true,
                        onTick: () {
                          smokeComp.flipVerticallyAroundCenter();
                        }),
                    OpacityEffect.fadeOut(DelayedEffectController(
                      EffectController(duration: 1),
                      delay: 5,
                    ))
                  ]));
              },
            )));
        }
      }),
    );
    return super.onLoad();
  }
}
