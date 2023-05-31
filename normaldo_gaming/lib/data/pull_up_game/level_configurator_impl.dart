import 'dart:math';

import 'package:normaldo_gaming/domain/pull_up_game/level_configurator.dart';

class LevelConfiguratorImpl implements LevelConfigurator {
  @override
  double itemSpeed(int level) {
    final speed = (200 + (10 * level)).toDouble();
    if (level > 20) {
      return (200 + (10 * 20)).toDouble();
    }
    return speed;
  }

  @override
  double itemCreationPeriod(int level) {
    final period = pow(0.9, level + 1).toDouble();
    return period;
  }
}
