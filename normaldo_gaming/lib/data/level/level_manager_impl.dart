import 'dart:async';
import 'dart:math';

import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

class LevelManagerImpl implements LevelManager {
  LevelManagerImpl() {
    for (int i = 0; i < 3; i++) {
      addNewMission();
    }
  }
  final _missions = <Mission>[];

  final _streamController = StreamController<Mission>.broadcast();

  final _missionsProgress = <Mission, int>{};

  @override
  int? progressOf(Mission mission) {
    return _missionsProgress[mission];
  }

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
  List<Mission> get missions {
    return _missions;
  }

  @override
  Stream<Mission> get completedMissions =>
      _streamController.stream.asBroadcastStream();

  @override
  void checkState({required GameSessionState state}) {
    for (final mission in _missions) {
      if (mission.completed) continue;
      switch (mission) {
        case CollectPizzaInOneGameMission():
          if (state.score == mission.value) {
            _streamController.sink.add(mission);
            mission.completed = true;
          } else {
            _missionsProgress[mission] = state.score;
          }
        case FinishGameAtLevelMission():
          if (state.level == mission.value && state.isDead) {
            _streamController.sink.add(mission);
            mission.completed = true;
          }
        default:
          continue;
      }
    }
  }

  @override
  void checkHit({required Items hitItem}) {
    final crashMissions =
        _missions.where((element) => element.type == MissionType.crashItem);
    if (crashMissions.isEmpty) return;

    for (final mission in crashMissions) {
      if ((mission as CrashItemInOneGameMission).item == hitItem) {
        _missionsProgress[mission] = (_missionsProgress[mission] ?? 0) + 1;
        if (_missionsProgress[mission] == mission.value) {
          _streamController.sink.add(mission);
          _missionsProgress.remove(mission);
          mission.completed = true;
        }
      }
    }
  }

  @override
  void remove(Mission mission) {
    _missions.remove(mission);
  }

  @override
  void addNewMission() {
    Mission mission = _allMissions[Random().nextInt(_allMissions.length)];
    while (_missions.any((m) => m.type == mission.type)) {
      mission = _allMissions[Random().nextInt(_allMissions.length)];
    }
    _missions.add(mission);
  }

  @override
  void insertNewMission(int index) {
    Mission mission = _allMissions[Random().nextInt(_allMissions.length)];
    while (_missions.any((m) => m.type == mission.type)) {
      mission = _allMissions[Random().nextInt(_allMissions.length)];
    }
    _missions.insert(index, mission);
  }
}

final _allMissions = [
  CollectPizzaInOneGameMission(
    exp: 1,
    value: 50,
  ),
  CollectPizzaInOneGameMission(
    exp: 2,
    value: 150,
  ),
  CollectPizzaInOneGameMission(
    exp: 3,
    value: 250,
  ),
  FinishGameAtLevelMission(
    description: 'End game before exiting the lair',
    exp: 1,
    value: 0,
  ),
  FinishGameAtLevelMission(
    description: 'End game at a GLEB piece',
    exp: 2,
    value: 6,
  ),
  FinishGameAtLevelMission(
    description: 'End game at a club entrance',
    exp: 3,
    value: 21,
  ),
  CrashItemInOneGameMission(
    item: Items.trashBin,
    exp: 3,
    value: 3,
  ),
  CrashItemInOneGameMission(
    item: Items.molotov,
    exp: 3,
    value: 1,
  ),
  CrashItemInOneGameMission(
    item: Items.cocktail,
    exp: 1,
    value: 3,
  ),
];
