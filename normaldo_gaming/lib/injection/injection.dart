import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';

final injector = Injector();

void initializeInjector() {
  // Cubits
  injector.map<UserCubit>((injector) => UserCubit());
  injector.map<GameSessionCubit>((injector) => GameSessionCubit());
}
