import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/big_buddy_bin.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bosses/shredder/shredder.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/punch.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class Shuriken extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  Shuriken() : super(anchor: Anchor.center);

  late final eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    if (!hearsBloc) return;
    speed = state.level.speed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && !other.immortal) {
      other.takeHit();
      audio.playSfx(Sfx.binCrash, customAssets: other.skin.assets.sfx['hit']);
      removeFromParent();
    }
    if (other is GameObject &&
        !disabled &&
        other is! Punch &&
        other is! BigBuddyBin &&
        other is! Shredder) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    const double startEffectsDelay = 0.3;
    disabled = true;
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    scale = Vector2.all(0);
    final grid = (gameRef as PullUpGame).grid;
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('shuriken.png'),
    ));
    add(ScaleEffect.to(
        Vector2.all(1),
        EffectController(
          duration: startEffectsDelay,
        )));
    add(RotateEffect.by(
        pi * 2,
        EffectController(
          duration: 0.5,
          infinite: true,
          startDelay: startEffectsDelay,
        )));
    add(TimerComponent(
        period: startEffectsDelay,
        removeOnFinish: true,
        onTick: () {
          final nPosition = grid.normaldo.position;
          final distinction = nPosition - position;
          final destination = nPosition + (distinction * 3);
          add(MoveToEffect(
            destination,
            EffectController(
              speed: speed * 1.2,
            ),
            onComplete: () => removeFromParent(),
          ));
        }));

    add(eatingHitbox);

    return super.onLoad();
  }

  @override
  bool get isSoloSpawn => false;

  @override
  Items get item => Items.shuriken;
}
