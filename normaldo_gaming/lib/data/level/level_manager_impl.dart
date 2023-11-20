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
  static const _ranks = [
    'Hungerling',
    'Nibbler',
    'Gourmand',
    'Muncher',
    'Glutton',
    'Sweet Tooth',
    'Foodie',
    'Foodie-Pro',
    'Devourer',
    'Gutspiller',
    'Digestor',
    'Epic Devourer',
    'Engulfer',
    'Abdominal Magnate',
    'Satiated Warrior',
    'Belly Gladiator',
    'Omnivorous Monster',
    'Bottomless Barrel',
    'Fat',
    'Universe Eater',
    'FATBOSS',
  ];

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
  int nextLevelExp(User user) {
    return switch (user.level) {
      0 => 3,
      1 || 2 => 5,
      3 || 4 => 7,
      5 || 6 => 9,
      7 || 8 || 9 || 10 => 10,
      100 => LevelManager.maxLevelExp,
      _ => (user.level + 1) + 2,
    };
  }

  @override
  String rank(User user) {
    return _ranks[user.level ~/ 5];
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
  void remove(Mission mission) {
    _missions.remove(mission);
    _repository.save(missions: missions);
  }

  @override
  void addNewMission() {
    _repository.save(missions: missions);
  }

  @override
  void insertNewMission(int index) {
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

  @override
  void completeMission(Mission mission) {
    _streamController.sink.add(mission);
    mission.completed = true;
  }
}
