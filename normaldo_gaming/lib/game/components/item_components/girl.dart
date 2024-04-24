import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class Girl extends SpriteComponent
    with HasGameRef<PullUpGame>, CollisionCallbacks, Item, SlowingItem {
  late final AudioPool _sfxPool;

  @override
  ShapeHitbox get hitbox => CircleHitbox.relative(
        0.9,
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.girl;

  @override
  bool get moving => true;

  @override
  void Function()? get onRemoved => null;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && !other.immortal) {
      _sfxPool.start();
      slow();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    final paths = [
      'girls3.png',
      'girls4 2.png',
    ];
    sprite = await Sprite.load(paths[Random().nextInt(paths.length)]);
    _sfxPool = await AudioPool.createFromAsset(
      path: 'audio/sfx/SLAP ALTYSHKA.mp3',
      maxPlayers: 1,
    );
    return super.onLoad();
  }
}
