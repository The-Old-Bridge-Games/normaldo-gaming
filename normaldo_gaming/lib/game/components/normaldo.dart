import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';

enum NormaldoHitState {
  idle,
  hit,
}

enum NormaldoFatState {
  skinny,
  slim,
  fat,
  uberFat,
}

class Normaldo extends SpriteGroupComponent<NormaldoFatState>
    with FlameBlocReader<GameSessionCubit, GameSessionState>, _StateActions {
  static const pizzaToGetFatter = 30;

  Normaldo({
    required Vector2 size,
  }) : super(size: size);

  bool _immortal = false;

  var _state = NormaldoHitState.idle;

  var _pizzaEaten = 0;

  set state(NormaldoHitState newState) {
    switch (newState) {
      case NormaldoHitState.idle:
        _immortal = false;
        _stopFlick();
        break;
      case NormaldoHitState.hit:
        _immortal = true;
        _startFlick();
        break;
    }
  }

  void nextFatState() {
    NormaldoFatState state;
    final indexOfCurrent = NormaldoFatState.values.indexOf(current!);
    if (indexOfCurrent + 1 == NormaldoFatState.values.length) {
      state = current!;
    } else {
      state = NormaldoFatState.values[indexOfCurrent + 1];
    }
    if (current != state) {
      current = state;
    }
  }

  void prevFatState() {
    NormaldoFatState state;
    final indexOfCurrent = NormaldoFatState.values.indexOf(current!);
    if (indexOfCurrent - 1 < 0) {
      state = current!;
    } else {
      state = NormaldoFatState.values[indexOfCurrent - 1];
    }
    if (current != state) {
      current = state;
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final skinnySprite = await Sprite.load('normaldo/normaldo1.png');
    final slimSprite = await Sprite.load('normaldo/normaldo2.png');
    final fatSprite = await Sprite.load('normaldo/normaldo3.png');
    final uberFatSprite = await Sprite.load('normaldo/normaldo4.png');

    final skinnyEatSprite = await Sprite.load('normaldo/normaldo1_eat.png');
    final slimEatSprite = await Sprite.load('normaldo/normaldo2_eat.png');
    final fatEatSprite = await Sprite.load('normaldo/normaldo3_eat.png');
    final uberEatFatSprite = await Sprite.load('normaldo/normaldo4_eat.png');

    sprites = {
      NormaldoFatState.skinny: skinnySprite,
      NormaldoFatState.slim: slimSprite,
      NormaldoFatState.fat: fatSprite,
      NormaldoFatState.uberFat: uberFatSprite,
    };

    current = NormaldoFatState.slim;

    add(RectangleHitbox());

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) => prevState.hit != newState.hit,
        onNewState: (cState) {
          if (cState.hit) {
            _pizzaEaten = 0;
            state = NormaldoHitState.hit;
          } else {
            state = NormaldoHitState.idle;
          }
        }));

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) => prevState.score < newState.score,
        onNewState: (_) {
          _pizzaEaten++;
          if (_pizzaEaten == pizzaToGetFatter) {
            _pizzaEaten = 0;
            nextFatState();
          }
        }));
    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) =>
            prevState.lives < newState.lives && newState.lives > 3,
        onNewState: (_) {
          nextFatState();
        }));
    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) =>
            prevState.lives > newState.lives && newState.lives <= 3,
        onNewState: (_) {
          prevFatState();
        }));
  }
}

mixin _StateActions on SpriteGroupComponent<NormaldoFatState> {
  Future<void> _startFlick() async {
    final controller = EffectController(
      duration: 0.1,
      reverseDuration: 0.1,
      infinite: true,
    );
    add(OpacityEffect.to(0, controller));
  }

  Future<void> _stopFlick() async {
    opacity = 1;
    removeWhere((component) => component is OpacityEffect);
  }
}
