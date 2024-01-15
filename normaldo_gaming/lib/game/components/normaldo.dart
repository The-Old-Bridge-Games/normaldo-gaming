import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/data/pull_up_game/mixins/has_audio.dart';
import 'package:normaldo_gaming/domain/app/sfx.dart';
import 'package:normaldo_gaming/domain/pull_up_game/eatable.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/game/components/effects_controller.dart';
import 'package:normaldo_gaming/game/components/notification_component.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/normaldo_sprites_fixture.dart';

/* 
SKINS IMPL
1. Batman ✅
*/

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
  skinnyDead;

  int pizzaToFat([int? amount]) {
    return 3;
    if (amount != null) return amount;
    return switch (this) {
      skinny || skinnyEat => 15,
      slim || slimEat => 40,
      fat || fatEat => 50,
      uberFat || uberFatEat => 60,
      _ => 1
    };
  }

  NormaldoFatState get dead {
    switch (this) {
      case NormaldoFatState.skinny:
      case NormaldoFatState.skinnyEat:
        return NormaldoFatState.skinnyDead;
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
        HasNgAudio,
        HasGameRef {
  static const smallHitboxRatio = 0.46;
  static const bigHitboxRatio = 0.5957;

  Normaldo({
    required Vector2 size,
    required this.skin,
    this.customPizzaToGetFatter,
  }) : super(size: size, anchor: Anchor.center);

  final Skin skin;

  bool _immortal = false;
  bool get immortal => _immortal;

  final int? customPizzaToGetFatter;
  late final EffectsController effectsController;

  var _state = NormaldoHitState.idle;

  int? get pizzaToGetFatter => current?.pizzaToFat(customPizzaToGetFatter);

  void takeHit() {
    if (_state == NormaldoHitState.idle) {
      decreaseFatPoints(current?.pizzaToFat(customPizzaToGetFatter) ?? 0);
    }
  }

  // 4DEV
  late final _circle = CircleComponent.relative(
    0.46,
    parentSize: size,
    anchor: anchor,
    position: Vector2(size.x / 2, size.y / 2 + size.y * 0.037),
    paint: Paint()..color = Colors.white.withOpacity(0.7),
  );
  late final _hitbox = CircleHitbox.relative(
    0.46,
    parentSize: size,
    anchor: anchor,
    position: Vector2(size.x / 2 + 10, size.y / 2 + size.y * 0.037),
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
    final pizzaToGetFatter = current!.pizzaToFat(customPizzaToGetFatter);
    _pizzaEaten += by;
    if (_pizzaEaten >= pizzaToGetFatter && !isFat && !isUberFat) {
      _pizzaEaten = _pizzaEaten % pizzaToGetFatter;
      nextFatState();
    } else if (_pizzaEaten >= pizzaToGetFatter && isFat) {
      _pizzaEaten = NormaldoFatState.uberFat.pizzaToFat();
      nextFatState();
    } else if (_pizzaEaten >= pizzaToGetFatter && isUberFat) {
      _pizzaEaten = NormaldoFatState.uberFat.pizzaToFat();
    }
  }

  void decreaseFatPoints(int by) {
    assert(by > 0);
    _pizzaEaten -= by;
    bloc.takeHit();
    if (_pizzaEaten <= 0 && !isSlim && !isSkinny) {
      _pizzaEaten = 0;
      prevFatState();
    } else if (_pizzaEaten <= 0 && isSlim) {
      _pizzaEaten = 0;
      prevFatState();
    } else if (_pizzaEaten <= 0 && isSkinny) {
      _pizzaEaten = 0;
      bloc.die();
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
    final index = NormaldoFatState.onlyIdle.indexOf(state);
    if (index == 3) {
      if (skin.assets.sfx['maxFat'] != null) {
        audio.playSfx(
          Sfx.weightIncreased,
          customAssets: skin.assets.sfx['maxFat']!,
          volume: 1.0,
        );
      }
      notify(
        text: 'MAX FAT!'.tr(),
        color: NGTheme.green1,
        fontSize: 18,
      );
    } else {
      if (customPizzaToGetFatter == null) {
        notify(text: '${'Fat'.tr()} ${index + 1} / 4', color: NGTheme.green1);
      }
    }
    if (current != state) {
      if (index != 3 || (skin.assets.sfx['maxFat'] == null && index == 3)) {
        audio.playSfx(
          Sfx.weightIncreased,
          customAssets: skin.assets.sfx['fatUp'],
        );
      }
      _changeFatAnimation(state);
    }
    if (index >= 2) {
      setHitboxPositionAndSize(size: size * bigHitboxRatio);
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
    final index = NormaldoFatState.onlyIdle.indexOf(state);
    if (customPizzaToGetFatter == null) {
      notify(text: '${'Fat'.tr()} ${index + 1} / 4', color: NGTheme.green1);
    }
    if (current != state) {
      audio.playSfx(Sfx.weightLoosed);
      _changeFatAnimation(state);
    }
    if (index < 2) {
      setHitboxPositionAndSize(size: size * smallHitboxRatio);
    }
  }

  void notify({
    required String text,
    Color? color,
    double? fontSize,
  }) {
    final grid = (gameRef as PullUpGame).grid;
    grid.add(
      NotificationComponent(
        text: text,
        color: color,
        fontSize: fontSize,
      )..position = position + Vector2(-10, -size.y / 2),
    );
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprites = await normaldoSprites(skin);

    current = NormaldoFatState.skinny;

    if (skin.assets.sfx['start'] != null) {
      audio.playSfx(Sfx.binCrash, customAssets: skin.assets.sfx['start']);
    }

    effectsController =
        EffectsController(onNewState: ((Items item, double duration) {
      final durString = duration.toInt().toString();
      final text = switch (item) {
        Items.cocktail => '${'Poisoned'.tr()} $durString',
        Items.hourglass => '${'Slow mo'.tr()} $durString',
        _ => '',
      };
      final color = switch (item) {
        Items.cocktail => Colors.purple,
        Items.hourglass => Colors.orange,
        _ => null,
      };
      notify(text: text, color: color);
    }));
    add(effectsController);

    // 4DEV
    add(_circle);

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
        listenWhen: (prevState, newState) =>
            prevState.isDead != newState.isDead,
        onNewState: (gameState) {
          if (gameState.isDead) {
            current = current?.dead;
            state = NormaldoHitState.hit;
          } else {
            current = NormaldoFatState.skinny;
            Future.delayed(const Duration(seconds: 2)).whenComplete(() {
              state = NormaldoHitState.idle;
            });
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

  void _changeFatAnimation(NormaldoFatState? state) {
    const dur = 0.25;
    const curve = Curves.bounceOut;
    addAll([
      RotateEffect.to(
          (Random().nextBool() ? pi : -pi) * 2,
          EffectController(
            duration: dur,
            reverseDuration: dur * 2,
            curve: curve,
          )),
      ScaleEffect.to(
          Vector2.all(0.1),
          EffectController(
              duration: dur,
              reverseDuration: dur * 2,
              curve: curve,
              onMax: () {
                current = state;
              }))
    ]);
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
