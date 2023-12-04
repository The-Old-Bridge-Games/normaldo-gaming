import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

import 'bomb.dart';
import 'bosses/shredder/shredder.dart';

class BigBuddyBin extends PositionComponent
    with
        HasGameRef,
        CollisionCallbacks,
        GameObject,
        FlameBlocReader<LevelBloc, LevelState>,
        FlameBlocListenable<LevelBloc, LevelState> {
  BigBuddyBin({this.exploding = false}) : super(anchor: Anchor.center);

  bool exploding;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    speed = state.level.speed * Utils.bigBuddyBinSpeedMultiplier;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    final gameSessionCubit = (gameRef as PullUpGame).gameSessionCubit;
    if (other is Normaldo) {
      if (gameSessionCubit.state.hit || gameSessionCubit.state.isDead) return;
      removeFromParent();
      other.takeHit();
      final grid = (gameRef as PullUpGame).grid;
      if (exploding) {
        grid.add(BombExplosionComponent()..size = grid.size);
        audio.playSfx(Sfx.bomb);
        Vibrate.vibrate();
      } else {
        audio.playSfx(Sfx.binCrash);
      }
    } else if (other is Shredder) {
      removeFromParent();
    } else {
      other.removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
  // FIXES:
  // 1. Updste speed of bigbuddy 🍕
  // 2. make bin destroy dollars
  // 3. reset fat point to the middle of previos fat

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed *
        Utils.bigBuddyBinSpeedMultiplier;
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('trash_bin.png'),
    ));
    add(RectangleHitbox.relative(
      Vector2(0.95, 0.95),
      parentSize: size,
    ));
    // ..collisionType = CollisionType.passive);

    return super.onLoad();
  }

  @override
  bool get isSoloSpawn => false;

  @override
  Items get item => Items.bigBuddyBin;
}
