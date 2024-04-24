import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class Pizza extends SpriteComponent
    with
        CollisionCallbacks,
        HasGameRef<PullUpGame>,
        Item,
        PizzaGivingItem,
        Eatable {
  late final List<AudioPool> _hitSfxPools;
  @override
  ShapeHitbox get hitbox => CircleHitbox.relative(
        0.8,
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.pizza;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo) {
      _hitSfxPools.random().start();
      givePizza();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('pizza.png');
    final skinBiteSfx = gameRef.grid.normaldo.skin.assets.sfx['bite'];
    if (skinBiteSfx != null) {
      final skinBitePools = await Future.wait(skinBiteSfx.map(
        (e) => AudioPool.createFromAsset(path: 'audio/skins/$e', maxPlayers: 1),
      ));
      _hitSfxPools = skinBitePools;
    } else {
      _hitSfxPools = [
        await AudioPool.createFromAsset(
          path: 'audio/sfx/havaet.mp3',
          maxPlayers: 1,
        ),
        await AudioPool.createFromAsset(
          path: 'audio/sfx/havaet2.mp3',
          maxPlayers: 1,
        ),
      ];
    }
    return super.onLoad();
  }
}
