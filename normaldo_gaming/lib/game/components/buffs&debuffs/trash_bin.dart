import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/utils/has_aura_mixin.dart';

class TrashBin extends PositionComponent
    with
        HasGameRef,
        CollisionCallbacks,
        HasLevelConfigurator,
        HasNgAudio,
        HasAura {
  TrashBin({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  @override
  Aura get aura => Aura.red;

  @override
  Component get auraComponent => RectangleComponent(
        size: size,
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo) {
      if (cubit.state.hit || cubit.state.isDead) return;
      removeFromParent();
      other.decreaseFatPoints(10);
      audio.playSfx(Sfx.binCrash);
      cubit.takeHit();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('trash_bin.png'),
    ));
    add(RectangleHitbox.relative(
      Vector2(0.9, 0.8),
      parentSize: size,
    ));
    // ..collisionType = CollisionType.passive);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= levelConfigurator.itemSpeed(cubit.state.level) * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }
}
