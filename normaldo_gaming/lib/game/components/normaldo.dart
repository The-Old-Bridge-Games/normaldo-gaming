import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/game/utils/normaldo_sprites_fixture.dart';

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
  uberFatEat,

  // dead states
  skinnyDead,
  slimDead,
  fatDead,
  uberFatDead;

  NormaldoFatState get dead {
    switch (this) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.skinnyEat:
        return NormaldoFatState.skinnyDead;
      case NormaldoFatState.slim:
      case NormaldoFatState.slimEat:
        return NormaldoFatState.slimDead;
      case NormaldoFatState.fat:
      case NormaldoFatState.fatEat:
        return NormaldoFatState.fatDead;
      case NormaldoFatState.uberFat:
      case NormaldoFatState.uberFatEat:
        return NormaldoFatState.uberFatDead;
      default:
        return this;
    }
  }

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
  static const pizzaToGetFatter = 1;

  Normaldo({
    required Vector2 size,
  }) : super(size: size, anchor: Anchor.center);

  bool _immortal = false;

  var _state = NormaldoHitState.idle;

  // 4DEV
  late final _circle = CircleComponent.relative(
    0.7,
    parentSize: size,
    anchor: anchor,
    position: Vector2(size.x / 2 + 10, size.y / 2),
    paint: Paint()..color = Colors.white.withOpacity(0.7),
  );
  late final _hitbox = CircleHitbox.relative(
    0.7,
    parentSize: size,
    anchor: anchor,
    position: Vector2(size.x / 2 + 10, size.y / 2),
  );

  void setHitboxPositionAndSize({Vector2? position, Vector2? size}) {
    if (position != null) {
      _hitbox.position = position;
      _circle.position = position;
    }
    if (size != null) {
      _hitbox.size = size;
      _circle.size = size;
    }
  }

  var _pizzaEaten = 0;
  int get fatPoints => _pizzaEaten;

  bool get isUberFat =>
      current == NormaldoFatState.uberFat ||
      current == NormaldoFatState.uberFatEat;
  bool get isSkinny =>
      current == NormaldoFatState.skinny ||
      current == NormaldoFatState.skinnyEat;

  bool get isSlim =>
      current == NormaldoFatState.slim || current == NormaldoFatState.slimEat;

  bool get isFat =>
      current == NormaldoFatState.fat || current == NormaldoFatState.fatEat;

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
    if (_pizzaEaten >= pizzaToGetFatter && !isFat && !isUberFat) {
      _pizzaEaten = _pizzaEaten % pizzaToGetFatter;
      nextFatState();
    } else if (_pizzaEaten >= pizzaToGetFatter && isFat) {
      _pizzaEaten = pizzaToGetFatter;
      nextFatState();
    } else if (_pizzaEaten >= pizzaToGetFatter && isUberFat) {
      _pizzaEaten = pizzaToGetFatter;
    }
  }

  void decreaseFatPoints(int by) {
    assert(by > 0);
    _pizzaEaten -= by;
    if (_pizzaEaten <= 0 && !isSlim && !isSkinny) {
      _pizzaEaten = _pizzaEaten % pizzaToGetFatter;
      prevFatState();
    } else if (_pizzaEaten <= 0 && isSlim) {
      _pizzaEaten = 0;
      prevFatState();
    } else if (_pizzaEaten <= 0 && isSkinny) {
      _pizzaEaten = 0;
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
      _updateHitbox();
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
      _updateHitbox();
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprites = await normaldoSprites();

    current = NormaldoFatState.skinny;

    // 4DEV
    // add(_circle);

    add(_hitbox);

    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) => prevState.hit != newState.hit,
        onNewState: (cState) {
          if (cState.hit) {
            state = NormaldoHitState.hit;
          } else {
            state = NormaldoHitState.idle;
          }
        }));
    await add(FlameBlocListener<GameSessionCubit, GameSessionState>(
        listenWhen: (prevState, newState) => newState.isDead,
        onNewState: (_) {
          current = current?.dead;
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

  void _updateHitbox() {
    switch (current) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.skinnyEat:
      case NormaldoFatState.skinnyDead:
        setHitboxPositionAndSize(
            position: Vector2(size.x / 2 + 10, size.y / 2));
        break;
      case NormaldoFatState.slim:
      case NormaldoFatState.slimEat:
      case NormaldoFatState.slimDead:
        setHitboxPositionAndSize(position: Vector2(size.x / 2 + 5, size.y / 2));
        break;
      case NormaldoFatState.fat:
      case NormaldoFatState.fatEat:
      case NormaldoFatState.fatDead:
        setHitboxPositionAndSize(position: Vector2(size.x / 2 + 5, size.y / 2));
        break;
      case NormaldoFatState.uberFat:
      case NormaldoFatState.uberFatEat:
      case NormaldoFatState.uberFatDead:
        setHitboxPositionAndSize(position: Vector2(size.x / 2, size.y / 2));
        break;
      default:
        throw UnexpectedError();
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
