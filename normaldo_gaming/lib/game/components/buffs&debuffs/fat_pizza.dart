import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/has_aura_mixin.dart';

class FatPizza extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        Eatable,
        HasNgAudio,
        HasAura {
  FatPizza({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  @override
  Aura get aura => Aura.green;

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
    if (other is Normaldo) {
      cubit.addLives(1);
      removeFromParent();
      audio.playSfx(Sfx.eatFatPizza);
      // when lives are 5 and we try to add 1 more listeners will not work
      // because lives will also be 5
      (gameRef as PullUpGame).hungerBar.restoreBar();
      if (cubit.state.lives == 5) {
        other.nextFatState();
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('fat_pizza.png'),
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
    position.x -= levelConfigurator.itemSpeed(cubit.state.level) * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
  }
}
