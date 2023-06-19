import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';

class Pizza extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        Eatable,
        GameObject,
        FlameBlocReader<GameSessionCubit, GameSessionState> {
  Pizza() : super(anchor: Anchor.center);

  late final _eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.passive;

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => PolygonComponent(
        [
          Vector2(0, size.y / 2),
          Vector2(size.x, 0),
          Vector2(size.x, size.y),
        ],
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      bloc.eatPizza();
      other.increaseFatPoints(1);
      audio.playSfx(Sfx.eatPizza);
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('pizza.png'),
    ));

    add(_eatingHitbox);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= levelConfigurator.itemSpeed(bloc.state.level) * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }

  @override
  bool get isSoloSpawn => false;
}
