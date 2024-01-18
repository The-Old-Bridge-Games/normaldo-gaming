import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class PullUpGameOnboarding4 extends FlameGame with HasCollisionDetection {
  late final GameSessionCubit gameSessionCubit;
  @override
  FutureOr<void> onLoad() async {
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    final normaldo = Normaldo(
        size: Vector2.all(60), customPizzaToGetFatter: 2, skin: Skin.basic())
      ..position = normaldoPos;
    gameSessionCubit = injector.get();
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameSessionCubit, GameSessionState>(
            create: () => gameSessionCubit,
          ),
          FlameBlocProvider<LevelBloc, LevelState>(
            create: () => injector.get(),
          ),
        ],
        children: [
          normaldo,
        ],
      ),
    );
    start(normaldo);
    return super.onLoad();
  }

  void start(Normaldo normaldo) {
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    normaldo.removeWhere((component) => component is Effect);
    normaldo.position = normaldoPos;
    final pizzaSize = Items.pizza.getSize(60);
    add(Pizza()
      ..size = pizzaSize
      ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y));
    add(TimerComponent(
      period: 1,
      removeOnFinish: true,
      onTick: () => add(Pizza()
        ..size = pizzaSize
        ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y * 2)),
    ));
    add(TimerComponent(
        period: 4,
        removeOnFinish: true,
        onTick: () {
          add(TrashBin()
            ..size = Items.trashBin.getSize(60)
            ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y));
          add(TimerComponent(
              period: 2,
              removeOnFinish: true,
              onTick: () {
                add(Homeless()
                  ..size = Items.homeless.getSize(60)
                  ..position =
                      Vector2(size.x + pizzaSize.x, pizzaSize.y * 2.5));
                start(normaldo);
              }));
        }));
    EffectController controller({
      double startDelay = 0.0,
    }) =>
        EffectController(
          speed: 100,
          startDelay: startDelay,
        );
    normaldo.add(SequenceEffect([
      MoveByEffect(Vector2(100, -20), (controller(startDelay: 1))),
      MoveByEffect(Vector2(30, 40), controller()),
      MoveByEffect(Vector2(-130, -20), controller()),
    ]));
  }
}

class Pizza extends PositionComponent
    with Eatable, CollisionCallbacks, HasNgAudio {
  late final eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo) {
      other.increaseFatPoints(1);
      audio.playSfx(Sfx.eatPizza);
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('pizza.png'),
    ));

    add(eatingHitbox);

    add(MoveToEffect(
        Vector2(-1000, 0),
        EffectController(
          speed: 100,
        )));
    return super.onLoad();
  }
}

class TrashBin extends PositionComponent
    with CollisionCallbacks, HasNgAudio, HasGameRef {
  late final eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    final bloc = (gameRef as PullUpGameOnboarding4).gameSessionCubit;
    if (other is Normaldo) {
      if (other.immortal || bloc.state.isDead) return;
      removeFromParent();
      other.takeHit();
      audio.playSfx(Sfx.binCrash);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('trash_bin.png'),
    ));

    add(eatingHitbox);

    add(MoveToEffect(
        Vector2(-1000, position.y),
        EffectController(
          speed: 100,
        )));
    return super.onLoad();
  }
}

class Homeless extends PositionComponent
    with CollisionCallbacks, HasNgAudio, HasGameRef {
  late final eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    final bloc = (gameRef as PullUpGameOnboarding4).gameSessionCubit;
    if (other is Normaldo) {
      if (other.immortal || bloc.state.isDead) return;
      removeFromParent();
      other.takeHit();
      audio.playSfx(Sfx.binCrash);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('homeless1.png'),
    ));

    add(eatingHitbox);

    add(MoveToEffect(
        Vector2(-1000, position.y),
        EffectController(
          speed: 100,
        )));
    return super.onLoad();
  }
}
