import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_level_configurator.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/utils/has_aura_mixin.dart';
import 'package:normaldo_gaming/game/utils/solo_spawn.dart';

class MoneyBag extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        HasLevelConfigurator,
        HasNgAudio,
        HasAura,
        SoloSpawn {
  MoneyBag({required this.cubit}) : super(anchor: Anchor.center);

  final GameSessionCubit cubit;

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => CircleComponent()
    ..size = size
    ..paint = auraPaint;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      cubit.addDollars(10);
      audio.playSfx(Sfx.dollarCatch);
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('money_bag.png'),
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
