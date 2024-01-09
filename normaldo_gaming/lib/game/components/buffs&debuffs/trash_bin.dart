import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class TrashBin extends PositionComponent
    with
        HasGameRef,
        CollisionCallbacks,
        GameObject,
        FlameBlocReader<LevelBloc, LevelState>,
        FlameBlocListenable<LevelBloc, LevelState> {
  TrashBin() : super(anchor: Anchor.center);

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
      Set<Vector2> intersectionPoints, PositionComponent other) {
    final gameSessionCubit = (gameRef as PullUpGame).gameSessionCubit;
    if (other is Normaldo) {
      if (other.immortal || gameSessionCubit.state.isDead) return;
      removeFromParent();
      other.takeHit();
      audio.playSfx(Sfx.binCrash, customAssets: other.skin.assets.sfx['hit']);
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('trash_bin.png'),
    ));
    add(RectangleHitbox.relative(
      Vector2(0.9, 0.8),
      parentSize: size,
    ));
    // add(RectangleComponent.relative(Vector2(0.9, 0.8),
    //     parentSize: size, paint: Paint()..color = Colors.blue));
    // ..collisionType = CollisionType.passive);

    return super.onLoad();
  }

  @override
  bool get isSoloSpawn => false;

  @override
  Items get item => Items.trashBin;
}
