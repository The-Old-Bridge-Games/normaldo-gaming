import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

import 'items.dart';

abstract interface class LevelManager {
  static const maxLevelExp = -1;

  int nextLevelExp(User user);

  bool isMaxLevel(User user);

  List<Mission> get missions;

  Stream<Mission> get completedMissions;

  void checkState({required GameSessionState state});
  void checkHit({required Items hitItem});
}
