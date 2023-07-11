import 'dart:async';

import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/user/entities/user.dart';

class LevelManagerImpl implements LevelManager {
  final _missions = <Mission>[
    CollectPizzaInOneGameMission(
      exp: 1,
      pizzaCount: 50,
    ),
    FinishGameAtLevelMission(
      description: 'End game before exiting the lair',
      exp: 1,
      level: 0,
    ),
    CrashItemInOneGameMission(
      item: Items.trashBin,
      exp: 3,
      count: 3,
    ),
  ];

  final _streamController = StreamController<Mission>.broadcast();

  final _missionsProgress = <Mission, int>{};

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
  List<Mission> get missions => _missions;

  @override
  Stream<Mission> get completedMissions => _streamController.stream;

  @override
  void checkState({required GameSessionState state}) {
    final toRemove = <Mission>[];
    for (final mission in _missions) {
      switch (mission) {
        case CollectPizzaInOneGameMission():
          if (state.score == mission.pizzaCount) {
            _streamController.sink.add(mission);
            toRemove.add(mission);
          }
        case FinishGameAtLevelMission():
          if (state.level == 0 && state.isDead) {
            _streamController.sink.add(mission);
            toRemove.add(mission);
          }
        default:
          return;
      }
    }
    for (final e in toRemove) {
      _missions.remove(e);
    }
  }

  @override
  void checkHit({required Items hitItem}) {
    final crashMissions =
        _missions.where((element) => element.type == MissionType.crashItem);
    if (crashMissions.isEmpty) return;

    final toRemove = <Mission>[];
    for (final mission in crashMissions) {
      if ((mission as CrashItemInOneGameMission).item == hitItem) {
        _missionsProgress[mission] = (_missionsProgress[mission] ?? 0) + 1;
        if (_missionsProgress[mission] == mission.count) {
          _streamController.sink.add(mission);
          toRemove.add(mission);
          _missionsProgress.remove(mission);
        }
      }
    }
    for (final e in toRemove) {
      _missions.remove(e);
    }
  }
}
