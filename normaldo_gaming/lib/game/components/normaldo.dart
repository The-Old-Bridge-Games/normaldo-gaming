import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';

enum NormaldoHitState {
  idle,
  hit,
}

enum NormaldoFatState {
  skinny,
  slim,
  fat,
  uberFat,

  // eating states
  skinnyEat,
  slimEat,
  fatEat,
  uberFatEat;

  static List<NormaldoFatState> get onlyIdle => [
        skinny,
        slim,
        fat,
        uberFat,
      ];

  static List<NormaldoFatState> get onlyEating => [
        skinnyEat,
        slimEat,
        fatEat,
        uberFatEat,
      ];
}

class Normaldo extends SpriteGroupComponent<NormaldoFatState>
    with
        FlameBlocReader<GameSessionCubit, GameSessionState>,
        _StateActions,
        CollisionCallbacks,
        HasNgAudio {
  static const pizzaToGetFatter = 20;

  Normaldo({
    required Vector2 size,
  }) : super(size: size);

  bool _immortal = false;

  var _state = NormaldoHitState.idle;

  var _pizzaEaten = 0;
  int get fatPoints => _pizzaEaten;

  bool get isPreEating {
    switch (current) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.slim:
      case NormaldoFatState.fat:
      case NormaldoFatState.uberFat:
        return false;
      default:
        return true;
    }
  }

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

  void increaseFatPoints(int by) {
    assert(by > 0);
    _pizzaEaten += by;
    if (_pizzaEaten >= pizzaToGetFatter) {
      _pizzaEaten = _pizzaEaten % pizzaToGetFatter;
      nextFatState();
    }
  }

  void decreaseFatPoints(int by) {
    assert(by > 0);
    _pizzaEaten -= by;
    if (_pizzaEaten <= 0) {
      _pizzaEaten = _pizzaEaten % pizzaToGetFatter;
      prevFatState();
    }
  }

  Future<void> nextFatState() async {
    NormaldoFatState state;
    await Future.delayed(const Duration(milliseconds: 200));
    toIdleFatState();
    final indexOfCurrent = NormaldoFatState.onlyIdle.indexOf(current!);
    if (indexOfCurrent + 1 == NormaldoFatState.onlyIdle.length) {
      state = current!;
    } else {
      state = NormaldoFatState.onlyIdle[indexOfCurrent + 1];
    }
    if (current != state) {
      audio.playSfx(Sfx.weightIncreased);
      current = state;
    }
  }

  Future<void> prevFatState() async {
    NormaldoFatState state;
    await Future.delayed(const Duration(milliseconds: 200));
    toIdleFatState();
    final indexOfCurrent = NormaldoFatState.onlyIdle.indexOf(current!);
    if (indexOfCurrent - 1 < 0) {
      state = current!;
    } else {
      state = NormaldoFatState.onlyIdle[indexOfCurrent - 1];
    }
    if (current != state) {
      audio.playSfx(Sfx.weightLoosed);
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

      // eating
      NormaldoFatState.skinnyEat: skinnyEatSprite,
      NormaldoFatState.slimEat: slimEatSprite,
      NormaldoFatState.fatEat: fatEatSprite,
      NormaldoFatState.uberFatEat: uberEatFatSprite,
    };

    current = NormaldoFatState.slim;

    add(RectangleHitbox());

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) => prevState.hit != newState.hit,
        onNewState: (cState) {
          if (cState.hit) {
            state = NormaldoHitState.hit;
          } else {
            state = NormaldoHitState.idle;
          }
        }));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Eatable && !isPreEating) {
      toEatingState();
      Future.delayed(const Duration(milliseconds: 200))
          .whenComplete(() => toIdleFatState());
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void toEatingState() {
    switch (current) {
      case NormaldoFatState.skinny:
        current = NormaldoFatState.skinnyEat;
        break;
      case NormaldoFatState.slim:
        current = NormaldoFatState.slimEat;
        break;
      case NormaldoFatState.fat:
        current = NormaldoFatState.fatEat;
        break;
      case NormaldoFatState.uberFat:
        current = NormaldoFatState.uberFatEat;
        break;
      default:
        break;
    }
  }

  void toIdleFatState() {
    switch (current) {
      case NormaldoFatState.skinnyEat:
        current = NormaldoFatState.skinny;
        break;
      case NormaldoFatState.slimEat:
        current = NormaldoFatState.slim;
        break;
      case NormaldoFatState.fatEat:
        current = NormaldoFatState.fat;
        break;
      case NormaldoFatState.uberFatEat:
        current = NormaldoFatState.uberFat;
        break;
      default:
        break;
    }
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
