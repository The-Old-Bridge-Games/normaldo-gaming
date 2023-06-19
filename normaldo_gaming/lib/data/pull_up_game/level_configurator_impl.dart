import 'dart:math';

import 'package:normaldo_gaming/domain/pull_up_game/level/level.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_configurator.dart';

class LevelConfiguratorImpl implements LevelConfigurator {
  @override
  double itemSpeed(int level) {
    final speed = (200 + (10 * level)).toDouble();
    if (level > 30) {
      return (200 + (10 * 20)).toDouble();
    }
    return speed;
  }

  @override
  double itemCreationPeriod(int level) {
    final period = pow(0.9, level + 1).toDouble();
    if (level >= 10) {
      return pow(0.9, 10).toDouble();
    }
    return period;
  }
}

class LevelController {
  Level get firstLevel => LinearLevel(
        cubit: cubit,
        frequency: 0.5,
        itemsChances: itemsChances,
      );
}
