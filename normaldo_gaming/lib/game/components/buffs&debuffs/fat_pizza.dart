import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';

class FatPizza extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        GameObject,
        FlameBlocReader<GameSessionCubit, GameSessionState> {
  FatPizza() : super(anchor: Anchor.center);

  @override
  Aura get aura => Aura.green;

  @override
  Component get auraComponent => PolygonComponent(
        [
          Vector2(size.x * 0.3, 0), // top point
          Vector2(size.x, size.y * 0.3), // right point
          Vector2(size.x * 0.7, size.y), // bottom point
          Vector2(0, size.y * 0.5), // left point
        ],
        size: size * 1.2,
        paint: auraPaint,
      );

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      bloc.addLives(1);
      removeFromParent();
      other.increaseFatPoints(10);
      audio.playSfx(Sfx.eatFatPizza);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('pizza_pack1.png'),
    ));
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    add(ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(
          infinite: true,
          duration: 0.3,
          reverseDuration: 0.3,
        )));

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
  bool get isSoloSpawn => true;
}
