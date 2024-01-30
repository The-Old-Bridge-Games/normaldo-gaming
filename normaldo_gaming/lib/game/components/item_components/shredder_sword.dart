// import 'dart:async';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flame_bloc/flame_bloc.dart';
// import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
// import 'package:normaldo_gaming/domain/app/sfx.dart';
// import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
// import 'package:normaldo_gaming/game/components/item_components/bosses/shredder/shredder.dart';
// import 'package:normaldo_gaming/game/components/item_components/punch.dart';
// import 'package:normaldo_gaming/game/components/game_object.dart';
// import 'package:normaldo_gaming/game/components/normaldo.dart';
// import 'package:normaldo_gaming/game/pull_up_game.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class ShredderSword extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item {
  @override
  // TODO: implement hitbox
  ShapeHitbox get hitbox => throw UnimplementedError();

  @override
  // TODO: implement item
  Items get item => throw UnimplementedError();
}

// class ShredderSword extends PositionComponent
//     with
//         CollisionCallbacks,
//         HasGameRef,
//         GameObject,
//         FlameBlocListenable<LevelBloc, LevelState> {
//   ShredderSword() : super(anchor: Anchor.center);

//   late final eatingHitbox = RectangleHitbox.relative(
//     Vector2.all(0.9),
//     parentSize: size,
//   )..collisionType = CollisionType.active;

//   @override
//   bool listenWhen(LevelState previousState, LevelState newState) {
//     return previousState.level != newState.level;
//   }

//   @override
//   void onNewState(LevelState state) {
//     if (!hearsBloc) return;
//     speed = state.level.speed;
//   }

//   @override
//   void onCollisionStart(
//     Set<Vector2> intersectionPoints,
//     PositionComponent other,
//   ) {
//     if (other is Normaldo && !other.immortal) {
//       other.takeHit();
//       audio.playSfx(Sfx.binCrash, customAssets: other.skin.assets.sfx['hit']);
//     }
//     if (other is GameObject &&
//         !disabled &&
//         other is! Punch &&
//         other is! Shredder &&
//         other is! Normaldo) {
//       other.removeFromParent();
//     }
//     super.onCollisionStart(intersectionPoints, other);
//   }

//   @override
//   Future<void> onLoad() async {
//     autoRemove = false;
//     disabled = true;
//     speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
//     add(SpriteComponent(
//       size: size,
//       sprite: await Sprite.load('shredder_sword.png'),
//     ));

//     add(eatingHitbox);

//     return super.onLoad();
//   }

//   @override
//   bool get isSoloSpawn => false;

//   @override
//   Items get item => Items.shredderSword;
// }
