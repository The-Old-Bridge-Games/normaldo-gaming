import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

abstract interface class LevelManager {
  static const maxLevelExp = -1;

  int nextLevelExp(User user);

  String rank(User user);

  bool isMaxLevel(User user);

  List<Mission> get missions;

  Stream<Mission> get completedMissions;

  Future<void> init();

  void cleanProgress();

  void remove(Mission mission);
  void addNewMission();
  void insertNewMission(int index);
}
