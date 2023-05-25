import 'dart:math';

import 'package:normaldo_gaming/domain/pull_up_game/level_configurator.dart';

class LevelConfiguratorImpl implements LevelConfigurator {
  @override
  double itemSpeed(int level) {
    final speed = (200 + (20 * level)).toDouble();
    return speed;
  }

  @override
  double itemCreationPeriod(int level) {
    final period = pow(0.9, level + 1).toDouble();
    return period;
  }
}
