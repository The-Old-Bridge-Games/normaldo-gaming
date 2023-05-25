import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';

class Levels extends TimerComponent
    with FlameBlocReader<GameSessionCubit, GameSessionState> {
  static const double levelChangeSeconds = 30.0;

  Levels() : super(period: levelChangeSeconds, repeat: true);

  @override
  void onTick() {
    bloc.setLevel(bloc.state.level + 1);
  }
}
