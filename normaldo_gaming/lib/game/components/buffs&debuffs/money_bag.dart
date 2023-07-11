import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/aura.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/game_object.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';

class MoneyBag extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef,
        GameObject,
        FlameBlocListenable<LevelBloc, LevelState> {
  MoneyBag() : super(anchor: Anchor.center);

  @override
  Aura get aura => Aura.blue;

  @override
  Component get auraComponent => CircleComponent()
    ..size = size
    ..paint = auraPaint;

  @override
  bool listenWhen(LevelState previousState, LevelState newState) {
    return previousState.level != newState.level;
  }

  @override
  void onNewState(LevelState state) {
    speed = state.level.speed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Normaldo) {
      (gameRef as PullUpGame).gameSessionCubit.addDollars(10);
      audio.playSfx(Sfx.dollarCatch);
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    speed = (gameRef as PullUpGame).levelBloc.state.level.speed;
    add(auraComponent);
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('money_bag.png'),
    ));
    add(CircleHitbox(
      radius: size.x / 2,
    )..collisionType = CollisionType.passive);
    // 4DEV
    // add(CircleComponent(
    //   radius: size.x / 2,
    //   paint: Paint()..color = Colors.white.withOpacity(0.7),
    // ));
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
  bool get isSoloSpawn => true;

  @override
  Items get item => Items.moneyBag;
}
