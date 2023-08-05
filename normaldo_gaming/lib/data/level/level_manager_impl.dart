import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/pull_up_game/missions/missions_repository.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

class LevelManagerImpl implements LevelManager {
  LevelManagerImpl(this._repository);
  final MissionsRepository _repository;

  final _missions = <Mission>[];

  final _streamController = StreamController<Mission>.broadcast();

  final _missionsProgress = <Mission, int>{};

  @override
  Future<void> init() async {
    final missions = await _repository.fetchMissions();
    if (missions == null || missions.isEmpty) {
      for (int i = 0; i < 3; i++) {
        addNewMission();
      }
      _repository.save(missions: _missions);
    } else {
      _missions.addAll(missions);
    }
  }

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
    _repository.saveProgress(progress: _missionsProgress);
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
    _repository.saveProgress(progress: _missionsProgress);
  }

  @override
  void remove(Mission mission) {
    _missions.remove(mission);
    _repository.save(missions: missions);
  }

  @override
  void addNewMission() {
    Mission mission = _allMissions[Random().nextInt(_allMissions.length)];
    while (_missions.any((m) => m.type == mission.type)) {
      mission = _allMissions[Random().nextInt(_allMissions.length)];
    }
    _missions.add(mission);
    _repository.save(missions: missions);
  }

  @override
  void insertNewMission(int index) {
    Mission mission = _allMissions[Random().nextInt(_allMissions.length)];
    while (_missions.any((m) => m.type == mission.type)) {
      mission = _allMissions[Random().nextInt(_allMissions.length)];
    }
    _missions.insert(index, mission);
    _repository.save(missions: missions);
  }

  @override
  void cleanProgress() {
    for (final mission in missions) {
      if (mission.isOneGame) {
        _missionsProgress.remove(mission);
      }
    }
    _repository.saveProgress(progress: _missionsProgress);
  }
}

final _allMissions = [
  CollectPizzaInOneGameMission(
    exp: 1,
    value: 50,
  ),
  CollectPizzaInOneGameMission(
    exp: 1,
    value: 70,
  ),
  CollectPizzaInOneGameMission(
    exp: 1,
    value: 100,
  ),
  CollectPizzaInOneGameMission(
    exp: 2,
    value: 150,
  ),
  CollectPizzaInOneGameMission(
    exp: 3,
    value: 200,
  ),
  CollectPizzaInOneGameMission(
    exp: 3,
    value: 250,
  ),
  FinishGameAtLevelMission(
    description: 'End game before exiting the lair'.tr(),
    exp: 1,
    value: 0,
  ),
  FinishGameAtLevelMission(
    description: 'End game at a GLEB piece'.tr(),
    exp: 2,
    value: 6,
  ),
  FinishGameAtLevelMission(
    description: 'End game at slot machines'.tr(),
    exp: 2,
    value: 9,
  ),
  FinishGameAtLevelMission(
    description: 'Finish the game by just popping out of the sewers'.tr(),
    exp: 2,
    value: 14,
  ),
  FinishGameAtLevelMission(
    description: 'End game at a club entrance'.tr(),
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
    exp: 2,
    value: 1,
  ),
  CrashItemInOneGameMission(
    item: Items.cocktail,
    exp: 1,
    value: 3,
  ),
  CrashItemInOneGameMission(
    item: Items.trashBin,
    exp: 1,
    value: 1,
  ),
  CrashItemInOneGameMission(
    item: Items.punch,
    exp: 1,
    value: 1,
  ),
  CrashItemInOneGameMission(
    item: Items.dumbbell,
    exp: 2,
    value: 2,
  ),
];
