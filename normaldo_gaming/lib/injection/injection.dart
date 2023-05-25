import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/data/pull_up_game/level_configurator_impl.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_configurator.dart';

final injector = Injector();

void initializeInjector() {
  // Cubits
  injector.map<UserCubit>((injector) => UserCubit());
  injector.map<GameSessionCubit>((injector) => GameSessionCubit());

  // Helpers
  injector.map<LevelConfigurator>(
    (injector) => LevelConfiguratorImpl(),
    isSingleton: true,
  );
}
