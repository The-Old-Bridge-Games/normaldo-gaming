import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/game/components/effects_controller.dart';
import 'package:normaldo_gaming/game/components/item_components/bosses/boss_component.dart';
import 'package:normaldo_gaming/game/components/item_components/explosion_component.dart';
import 'package:normaldo_gaming/game/components/normaldo.dart';
import 'package:normaldo_gaming/game/pull_up_game.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

mixin Item on PositionComponent, HasGameRef<PullUpGame>, CollisionCallbacks {
  Items get item;
  bool get autoRemove => true;
  void Function()? get onRemoved => null;
  bool get collidable => _collidable;
  bool get moving => _moving;
  double get speed => game.levelBloc.state.level.speed * _speedMultiplier;
  PositionComponent get hitbox;

  set speedMultiplier(double newValue) {
    _speedMultiplier = newValue;
  }

  set moving(bool newValue) {
    _moving = newValue;
  }

  set collidable(bool newValue) {
    _collidable = newValue;
    if (collidable) {
      _addHitbox();
    } else {
      _removeHitbox();
    }
  }

  LevelManager get levelManager => game.levelManager;

  var _collidable = true;
  double _speedMultiplier = 1;
  bool _moving = true;

  void _addHitbox() {
    add(hitbox..position = Vector2(size.x / 2, size.y / 2));
  }

  void _removeHitbox() {
    if (children.whereType<ShapeHitbox>().isNotEmpty) {
      removeWhere((e) => e is ShapeHitbox);
    }
  }

  @override
  Anchor get anchor => Anchor.center;

  @override
  @mustCallSuper
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (!collidable) return;
    if (other is Normaldo && !other.immortal) {
      levelManager.checkHit(hitItem: item);
    }
    if (other is KillingItem ||
        (other is AttackingItem &&
            this is! AttackingItem &&
            this is! NormaldoAttack)) {
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  FutureOr<void> onLoad() {
    add(hitbox..position = Vector2(size.x / 2, size.y / 2));
    anchor = anchor;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (moving) {
      position.x -= speed * dt;
    }
    if (autoRemove) {
      if (position.x < -size.x) {
        removeFromParent();
      }
    }
  }

  @override
  void onRemove() {
    onRemoved?.call();
    super.onRemove();
  }
}

// ✅
mixin AttackingItem on Item {
  int get strength;
  int get damage;

  void attack(PositionComponent other) {
    if (other is NormaldoAttack) return;
    if (other is Normaldo && !other.immortal && !other.hasImmuneTo(item)) {
      other.takeHit(damage: damage);
      removeFromParent();
    }
    if (other is AttackingItem && other.collidable && strength > 0) {
      if (other.strength >= strength) {
        removeFromParent();
      }
    }
  }
}

// ✅
mixin SlowingItem on Item {
  void slow() {
    if (!game.grid.normaldo.hasImmuneTo(item)) {
      game.grid.normaldo.effectsController.addEffect(
        ItemEffect.slow,
        Utils.generateCocktailDuration(),
      );
      removeFromParent();
    }
  }
}

mixin SpeedUpItem on Item {
  void speedUp() {
    game.grid.normaldo.effectsController.addEffect(
      ItemEffect.speedUp,
      Utils.generateCocktailDuration(),
    );
  }
}

// ✅
mixin CleanScreenItem on Item {
  void cleanScreen([List<Items>? except]) {
    final grid = game.grid;
    Vibrate.vibrate();
    removeFromParent();
    grid.removeAllItems(
        exclude: grid.children
            .where((e) => e is Item && (except?.contains(e.item) ?? false))
            .toList());
    grid.add(ExplosionComponent()..size = grid.size);
  }
}

// ✅
mixin KillingItem on Item {
  void kill() {
    game.gameSessionCubit.die();
  }
}

// ✅
mixin ImmortalityItem on Item {
  void immortality({double? duration}) {
    game.grid.normaldo.effectsController.addEffect(
      ItemEffect.immortality,
      duration ?? 2 + Random().nextInt(4).toDouble(),
    );
  }
}

mixin ImmuneItem on Item {
  void immuneTo<T extends Item>() {
    if (T == AttackingItem) {
      game.grid.normaldo.effectsController.addEffect(
        ItemEffect.immuneToAttackingItems,
        Utils.generateCocktailDuration(),
      );
    } else if (T == SlowingItem) {
      game.grid.normaldo.effectsController.addEffect(
        ItemEffect.immuneToSlowingItems,
        Utils.generateCocktailDuration(),
      );
    }
  }
}

// ✅
mixin MoneytakeItem on Item {
  void takeMoney(int amount) {
    final normaldo = game.grid.normaldo;
    if (game.gameSessionCubit.state.dollars == 0) {
      normaldo.takeHit();
    } else {
      game.gameSessionCubit.takeDollars(amount);
      game.grid.normaldo.notify(
        text: '-$amount bucks',
        color: Colors.red,
      );
    }
  }
}

// ✅
mixin MoneygiveItem on Item {
  void giveMoney(int amount) {
    game.gameSessionCubit.addDollars(amount);
    game.grid.normaldo.notify(
      text: '+$amount bucks',
      color: Colors.greenAccent[600],
    );
  }

  @override
  FutureOr<void> onLoad() {
    add(ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(
          infinite: true,
          duration: 0.3,
          reverseDuration: 0.3,
        )));
    return super.onLoad();
  }
}

// ✅
mixin SlowMoItem on Item {
  void slowMo({double? duration}) {
    assert(duration == null || duration > 0);
    game.grid.normaldo.effectsController.addEffect(
      ItemEffect.slowMo,
      duration ?? Utils.generateHourglassDuration(),
    );
  }
}

// ✅
mixin PizzaGivingItem on Item {
  void givePizza() {
    game.gameSessionCubit.eatPizza();
    game.grid.normaldo.increaseFatPoints(1);
    removeFromParent();
  }

  @override
  FutureOr<void> onLoad() {
    add(ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(
          infinite: true,
          duration: 0.3,
          reverseDuration: 0.3,
        )));
    return super.onLoad();
  }
}

// ✅
mixin CustomEffectItem on Item {
  void applyEffect(void Function() onEffect) {
    onEffect();
  }
}

mixin NormaldoAttack on Item {
  void attack(Boss boss);
}

mixin Eatable on Item {}