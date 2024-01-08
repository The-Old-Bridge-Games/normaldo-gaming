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
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/injection/injection.dart';

class PullUpGameOnboarding3 extends FlameGame with HasCollisionDetection {
  late final GameSessionCubit gameSessionCubit;
  late final LevelBloc levelBloc;
  late final Normaldo normaldo;
  @override
  FutureOr<void> onLoad() async {
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    normaldo = Normaldo(size: Vector2.all(60), skin: Skin.basic())
      ..position = normaldoPos;
    gameSessionCubit = injector.get();
    levelBloc = injector.get();
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameSessionCubit, GameSessionState>(
            create: () => gameSessionCubit,
          ),
          FlameBlocProvider<LevelBloc, LevelState>(
            create: () => levelBloc,
          ),
        ],
        children: [
          normaldo,
        ],
      ),
    );
    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        bloc: gameSessionCubit,
        onNewState: (state) {
          if (state.isDead) {
            normaldo.removeWhere((component) => component is Effect);
            add(TimerComponent(
                period: 2,
                removeOnFinish: true,
                onTick: () {
                  start(normaldo);
                }));
          }
        }));
    start(normaldo);
    return super.onLoad();
  }

  void start(Normaldo normaldo) {
    gameSessionCubit.revive();
    final normaldoPos = Vector2(size.x * 0.5, size.y / 2);
    normaldo.removeWhere((component) => component is Effect);
    normaldo.position = normaldoPos;
    final pizzaSize = Items.trashBin.getSize(60);
    add(TrashBin()
      ..size = pizzaSize
      ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y));
    add(TimerComponent(
      period: 2,
      removeOnFinish: true,
      onTick: () => add(Homeless()
        ..size = Items.homeless.getSize(60)
        ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y * 3)),
    ));
    add(TimerComponent(
      period: 3.5,
      removeOnFinish: true,
      onTick: () => add(Molotov()
        ..size = Items.molotov.getSize(60)
        ..position = Vector2(size.x + pizzaSize.x, pizzaSize.y * 1.5)),
    ));
    EffectController controller({
      double startDelay = 0.0,
    }) =>
        EffectController(
          speed: 100,
          startDelay: startDelay,
        );
    normaldo.add(SequenceEffect([
      MoveByEffect(Vector2(40, 40), (controller(startDelay: 1))),
      MoveByEffect(Vector2(30, -50), controller(startDelay: 1.5)),
      MoveByEffect(Vector2(-30, -40), controller(startDelay: 3)),
      // MoveByEffect(Vector2(-40, 20), controller()),
    ], onComplete: () {
      start(normaldo);
    }));
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
    final bloc = (gameRef as PullUpGameOnboarding3).gameSessionCubit;
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
    final bloc = (gameRef as PullUpGameOnboarding3).gameSessionCubit;
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

class Molotov extends PositionComponent
    with CollisionCallbacks, HasNgAudio, HasGameRef {
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    final bloc = (gameRef as PullUpGameOnboarding3).gameSessionCubit;
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
    add(SpriteAnimationComponent(
      anchor: anchor,
      animation: SpriteAnimation.spriteList(
        [
          await Sprite.load('molotov1.png'),
          await Sprite.load('molotov2.png'),
        ],
        stepTime: 0.5,
      ),
      size: size,
    ));
    add(RectangleHitbox(
      position: Vector2(10, 0),
      size: Vector2(size.x * 0.8, size.y),
    ));

    add(MoveToEffect(
        Vector2(-1000, position.y),
        EffectController(
          speed: 100,
        )));
    return super.onLoad();
  }
}
