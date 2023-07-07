import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

abstract interface class LevelManager {
  static const maxLevelExp = -1;

  int nextLevelExp(User user);

  bool isMaxLevel(User user);

  List<Mission> missions();
}
