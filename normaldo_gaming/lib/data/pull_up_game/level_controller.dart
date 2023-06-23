import 'dart:async';
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
      Items.dollar: 0.044,
      Items.moneyBag: 0.002,
      Items.dumbbell: 0.010,
      Items.fatPizza: 0.002,
      Items.cocktail: 0.050,
      Items.bomb: 0.050,
      Items.molotov: 0.060
    },
    6: {
      Items.trashBin: 0.412,
      Items.pizza: 0.370,
      Items.dollar: 0.034,
      Items.moneyBag: 0.002,
      Items.dumbbell: 0.010,
      Items.fatPizza: 0.002,
      Items.cocktail: 0.050,
      Items.bomb: 0.050,
      Items.molotov: 0.060,
      Items.hourglass: 0.010,
    },
  };

  LevelController();

  LinearLevel get linearLevel => _linearLevel;

  var _currentLevelNumber = 0;

  final _levelStreamController = StreamController<Level>.broadcast();

  Stream<Level> get stream => _levelStreamController.stream;

  /// has value if we forced speed value by something different from common levelling
  /// Ex.: using Hourglass item
  double? _forcedSpeed;

  var _linearLevel = LinearLevel(
    frequency: 0.5,
    speed: 200,
    itemsChances: _itemsAppearingByLevel[0]!,
  );

  void changeLevelSpeed({required double speed, required int duration}) {
    _forcedSpeed = speed;
    _linearLevel = _linearLevel.copyWith(speed: speed);
    _levelStreamController.sink.add(_linearLevel);
    Future.delayed(Duration(seconds: duration)).whenComplete(() {
      _forcedSpeed = null;
      _linearLevel = changeLevel(_currentLevelNumber) as LinearLevel;
      _levelStreamController.sink.add(_linearLevel);
    });
  }

  Level changeLevel(int level) {
    _currentLevelNumber = level;
    var frequency = pow(0.9, level + 1).toDouble();
    var speed = (200 + (15 * level)).toDouble();
    if (level > 7) {
      frequency = pow(0.9, 12 + 1).toDouble();
      speed = (200 + (15 * 12)).toDouble();
    }
    if (_forcedSpeed != null) {
      speed = _forcedSpeed!;
    }
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
          onFinish: onFinish,
        );
    }
  }
}
