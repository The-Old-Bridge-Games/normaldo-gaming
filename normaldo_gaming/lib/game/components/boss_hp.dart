import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class BossHp extends PositionComponent
    with HasGameRef<PullUpGame>, CollisionCallbacks {
  BossHp({required this.boss}) : super(anchor: Anchor.center);

  final Boss boss;

  List<SpriteComponent> get hpComp =>
      children.whereType<SpriteComponent>().toList();

  void decrease() {
    final hp = children.whereType<SpriteComponent>();
    if (hp.isNotEmpty) {
      remove(hp.last);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo && hpComp.isNotEmpty && hpComp.first.opacity == 1) {
      for (var element in hpComp) {
        element.add(OpacityEffect.to(0.7, EffectController(duration: 0.3)));
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Normaldo) {
      for (var element in hpComp) {
        element.add(OpacityEffect.to(1, EffectController(duration: 0.3)));
      }
    }
    super.onCollisionEnd(other);
  }

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < boss.hp; i++) {
      if (boss is SpriteComponent) {
        add(SpriteComponent(
          sprite: (boss as SpriteComponent).sprite,
          size: Vector2.all(40),
          position: Vector2(i * 48, 0),
        ));
      } else {
        add(CircleComponent(
          radius: 20,
          paint: Paint()..color = Colors.red,
          position: Vector2(i * 48, 0),
        ));
      }
    }
    add(RectangleHitbox(size: Vector2(boss.hp * 48, 40)));
    return super.onLoad();
  }
}
