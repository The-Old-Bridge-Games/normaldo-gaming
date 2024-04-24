import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/item_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

final class Energizer extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PullUpGame>, Item, SpeedUpItem {
  late final AudioPool _sfxPool;

  @override
  ShapeHitbox get hitbox => RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        anchor: anchor,
      );

  @override
  Items get item => Items.energizer;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      _sfxPool.start(volume: 0.5);
      speedUp();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('energeticl.png');
    _sfxPool = await AudioPool.createFromAsset(
      path: 'audio/sfx/energy.mp3',
      maxPlayers: 1,
    );
    return super.onLoad();
  }
}
