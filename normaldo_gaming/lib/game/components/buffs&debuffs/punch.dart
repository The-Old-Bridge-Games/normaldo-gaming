import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/big_buddy_bin.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Punch extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Punch() : super(anchor: Anchor.center);

  bool _activated = false;

  late final RotateEffect _shakeEffect;

  @override
  Aura get aura => Aura.red;

  @override
  PositionComponent get auraComponent => RectangleComponent(
        size: size,
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
    if (other is Normaldo) {
      audio.playSfx(Sfx.bomb);
      other.takeHit();
      removeFromParent();
    }
    if (other is! Normaldo && other is! BigBuddyBin) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    _shakeEffect = RotateEffect.to(
        0.5,
        EffectController(
          speed: 50,
          reverseSpeed: 50,
          infinite: true,
        ));
    final grid = (gameRef as PullUpGame).grid;
    grid.stopLine(grid.linesCentersY.indexOf(position.y));
    grid.removeWhere((component) =>
        component is PositionComponent &&
        component.position.y == position.y &&
        component.position.x > position.x);
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('punch.png'),
    ));
    add(CircleHitbox.relative(
      0.9,
      parentSize: size,
    ));
    // 4DEV
    // add(CircleComponent.relative(
    //   0.9,
    //   parentSize: size,
    //   paint: Paint()..color = BasicPalette.blue.color.withOpacity(0.5),
    // ));

    add(_shakeEffect);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (_activated) return;
    final grid = (gameRef as PullUpGame).grid;
    if (position.x <= grid.size.x - (size.x / 2)) {
      _activated = true;
      add(TimerComponent(
          period: 1,
          removeOnFinish: true,
          onTick: () {
            audio.playSfx(Sfx.roundBox);
            remove(_shakeEffect);
            add(TimerComponent(
                period: 0.5,
                removeOnFinish: true,
                onTick: () {
                  add(MoveToEffect(
                      Vector2(-grid.size.x / 2, y),
                      EffectController(
                          duration: 1,
                          onMax: () {
                            grid.resumeLines();
                            removeFromParent();
                          })));
                }));
          }));
    }
    super.update(dt);
  }

  @override
  bool get isSoloSpawn => false;
}
