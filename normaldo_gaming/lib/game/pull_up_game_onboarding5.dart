import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/game/components/buffs&debuffs/bomb.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class PullUpGameOnboarding5 extends FlameGame with HasCollisionDetection {
  @override
  FutureOr<void> onLoad() async {
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    final normaldo = Normaldo(size: Vector2.all(60))..position = normaldoPos;
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameSessionCubit, GameSessionState>(
            create: () => injector.get(),
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
    add(Bomb()
      ..size = pizzaSize
      ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y));
    add(TimerComponent(
        period: 1,
        removeOnFinish: true,
        onTick: () {
          add(Pizza()
            ..size = pizzaSize
            ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y * 2));
          add(TimerComponent(
              period: 1,
              removeOnFinish: true,
              onTick: () {
                add(Pizza()
                  ..size = pizzaSize
                  ..position =
                      Vector2(size.x + pizzaSize.x, pizzaSize.y * 2.5));
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
      MoveByEffect(Vector2(100, -30), (controller(startDelay: 1))),
      MoveByEffect(Vector2(-50, 30), controller()),
      MoveByEffect(Vector2(-50, -10), controller()),
      // MoveByEffect(Vector2(-40, 20), controller()),
    ], onComplete: () {
      start(normaldo);
    }));
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

class Bomb extends PositionComponent
    with HasGameRef, CollisionCallbacks, HasNgAudio {
  late final _eatingHitbox = RectangleHitbox.relative(
    Vector2.all(0.9),
    parentSize: size,
  )..collisionType = CollisionType.active;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Normaldo && _eatingHitbox.isColliding) {
      final grid = (gameRef as PullUpGameOnboarding5);
      audio.playSfx(Sfx.bomb);
      Vibrate.vibrate();
      removeFromParent();
      grid.removeWhere((component) => component is! FlameMultiBlocProvider);
      grid.add(BombExplosionComponent()..size = grid.size);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() async {
    add(SpriteComponent(
      size: size,
      sprite: await Sprite.load('bomb.png'),
    ));

    add(_eatingHitbox);

    add(MoveToEffect(
        Vector2(-1000, 0),
        EffectController(
          speed: 100,
        )));
    return super.onLoad();
  }
}
