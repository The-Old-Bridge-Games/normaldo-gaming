import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

class LevelManagerImpl implements LevelManager {
  @override
  int nextLevelExp(User user) {
    return switch (user.level) {
      0 => 3,
      1 || 2 => 5,
      3 || 4 => 7,
      5 || 6 => 9,
      7 || 8 || 9 || 10 => 10,
      50 => LevelManager.maxLevelExp,
      _ => (user.level + 1) + 2,
    };
  }

  @override
  bool isMaxLevel(User user) => nextLevelExp(user) == LevelManager.maxLevelExp;

  @override
  List<Mission> missions() {
    return [
      const Mission(
        description: 'Get 50 pizza in one game',
        exp: 1,
      ),
      const Mission(
        description: 'End game before exiting the lair',
        exp: 1,
      ),
      const Mission(
        description: 'Crash 5 bins in one game',
        exp: 3,
      ),
    ];
  }
}
