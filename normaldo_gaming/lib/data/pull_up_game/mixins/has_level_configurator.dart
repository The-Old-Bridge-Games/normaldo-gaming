import 'package:normaldo_gaming/domain/pull_up_game/level_configurator.dart';
import 'package:normaldo_gaming/injection/injection.dart';

mixin HasLevelConfigurator {
  LevelConfigurator get levelConfigurator => injector.get();
}
