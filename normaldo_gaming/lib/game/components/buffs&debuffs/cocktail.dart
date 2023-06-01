import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/has_aura_mixin.dart';

class Cocktail extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        HasNgAudio,
        HasAura {
  Cocktail({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  final _eatingHitbox = RectangleHitbox()
    ..collisionType = CollisionType.passive;

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => CircleComponent(
        radius: size.x / 2,
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      audio.playSfx(Sfx.cocktail);
      removeFromParent();
      (gameRef as PullUpGame).grid.changeSpeed(
          multiplier: 0.2,
          duration: Duration(seconds: Random().nextInt(4) + 2));
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('cocktail.png'),
    ));
    add(_eatingHitbox..anchor = anchor);

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
