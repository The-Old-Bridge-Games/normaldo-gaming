import 'dart:math';

import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';

typedef FinishCallback = void Function();

enum Events {
  trashWall,
  cursedPath,
  guardedPizza,
}

class LevelController {
  static const _itemsAppearingByLevel = {
    0: {
      Items.trashBin: 0.5,
      Items.pizza: 0.5,
    },
    1: {
      Items.trashBin: 0.475,
      Items.pizza: 0.425,
      Items.dollar: 0.048,
      Items.moneyBag: 0.002,
      Items.dumbbell: 0.048,
      Items.fatPizza: 0.002,
    },
    2: {
      Items.trashBin: 0.400,
      Items.pizza: 0.400,
      Items.dollar: 0.05,
      Items.moneyBag: 0.002,
      Items.dumbbell: 0.050,
      Items.fatPizza: 0.002,
      Items.cocktail: 0.048,
      Items.bomb: 0.048,
    },
    4: {
      Items.trashBin: 0.392,
      Items.pizza: 0.350,
      Items.dollar: 0.050,
      Items.moneyBag: 0.002,
      Items.dumbbell: 0.008,
      Items.fatPizza: 0.002,
      Items.cocktail: 0.048,
      Items.bomb: 0.048,
      Items.molotov: 0.100
    },
    5: {
      Items.trashBin: 0.412,
      Items.pizza: 0.370,
      Items.dollar: 0.046,
      Items.moneyBag: 0.002,
      Items.dumbbell: 0.008,
      Items.fatPizza: 0.002,
      Items.cocktail: 0.050,
      Items.bomb: 0.050,
      Items.molotov: 0.060
    },
  };

  LinearLevel get linearLevel => _linearLevel;

  var _linearLevel = LinearLevel(
    frequency: 0.5,
    speed: 200,
    itemsChances: _itemsAppearingByLevel[0]!,
  );

  Level changeLevel(int level) {
    final frequency = pow(0.9, level + 1).toDouble();
    final speed = (200 + (15 * level)).toDouble();
    _linearLevel = LinearLevel(
      itemsChances: _itemsAppearingByLevel[level] ?? linearLevel.itemsChances,
      frequency: frequency,
      speed: speed,
    );
    return _linearLevel;
  }

  Level getEvent({required Events event, required FinishCallback onFinish}) {
    switch (event) {
      case Events.cursedPath:
        return EventLevel.cursedPath(
          speed: linearLevel.speed,
          onFinish: onFinish,
        );
      case Events.guardedPizza:
        return EventLevel.guardedPizza(
          speed: linearLevel.speed,
          onFinish: onFinish,
        );
      case Events.trashWall:
        return EventLevel.trashWall(
          speed: linearLevel.speed,
          frequency: linearLevel.frequency,
          onFinish: onFinish,
        );
    }
  }

  Level getRandomEvent({required FinishCallback onFinish}) {
    final event = Events.values[Random().nextInt(Events.values.length)];

    switch (event) {
      case Events.cursedPath:
        return EventLevel.cursedPath(
          speed: linearLevel.speed,
          onFinish: onFinish,
        );
      case Events.guardedPizza:
        return EventLevel.guardedPizza(
          speed: linearLevel.speed,
          onFinish: onFinish,
        );
      case Events.trashWall:
        return EventLevel.trashWall(
          speed: linearLevel.speed,
          frequency: linearLevel.frequency,
          onFinish: onFinish,
        );
    }
  }
}
