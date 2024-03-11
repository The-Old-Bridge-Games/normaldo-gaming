import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/pull_up_game/entities/reward.dart';
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
      100 => LevelManager.maxLevelExp,
      _ => (user.level + 1) + 2,
    };
  }

  @override
  String rank(User user) {
    if (_ranks.isEmpty) throw UnexpectedError();
    final level = user.level;
    if (level < 5) return _ranks[0];
    if (level < 7) return _ranks[1];
    if (level < 10) return _ranks[2];
    if (level < 13) return _ranks[3];
    if (level < 15) return _ranks[4];
    if (level < 17) return _ranks[5];
    if (level < 20) return _ranks[6];
    if (level < 23) return _ranks[7];
    if (level < 25) return _ranks[8];
    if (level < 27) return _ranks[9];
    if (level < 30) return _ranks[10];
    if (level < 33) return _ranks[11];
    if (level < 35) return _ranks[12];
    if (level >= 35) {
      final nextIndex = level - 22;
      if (nextIndex >= _ranks.length) {
        return _ranks[_ranks.length - 1];
      }
      return _ranks[nextIndex];
    }
    return _ranks[0];
  }

  String rankFromLvl(int lvl) {
    return rank(User(
      id: '',
      name: '',
      highScore: 0,
      dollars: 0,
      level: lvl,
      exp: 0,
      extraLives: 0,
      totalPizzas: 0,
      mySkins: [],
    ));
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

  @override
  List<List<Reward>> get levelUpRewards => [
        // 1 lvl
        [const TextReward(text: 'HERE WE GO')],
        // 2 lvl
        [const BucksReward(amount: 10)],
        // 3 lvl
        [const BucksReward(amount: 20)],
        // 4 lvl
        [const BucksReward(amount: 30)],
        // 5 lvl
        [
          const BucksReward(amount: 40),
          const ExtraLiveReward(amount: 2),
          RankReward(rank: rankFromLvl(5)),
          const SkinReward('viking'),
        ],
        // 6 lvl
        [const BucksReward(amount: 60)],
        // 7 lvl
        [
          const BucksReward(amount: 200),
          const ExtraLiveReward(amount: 2),
          RankReward(rank: rankFromLvl(7)),
        ],
        // 8 lvl
        [const BucksReward(amount: 100)],
        // 9 lvl
        [const BucksReward(amount: 120)],
        // 10 lvl
        [
          const BucksReward(amount: 300),
          const SkinReward('batman'),
          const ExtraLiveReward(amount: 5),
          RankReward(rank: rankFromLvl(10)),
        ],
        // 11 lvl
        [const BucksReward(amount: 200)],
        // 12 lvl
        [const BucksReward(amount: 300)],
        // 13 lvl
        [
          const BucksReward(amount: 400),
          RankReward(rank: rankFromLvl(13)),
          const ExtraLiveReward(amount: 3),
        ],
        // 14 lvl
        [const BucksReward(amount: 500)],
        // 15 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(15)),
          const ExtraLiveReward(amount: 3),
        ],
        // 16 lvl
        [const BucksReward(amount: 500)],
        // 17 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(17)),
          const SkinReward('dracula'),
          const ExtraLiveReward(amount: 3),
        ],
        // 18 lvl
        [const BucksReward(amount: 500)],
        // 19 lvl
        [const BucksReward(amount: 500)],
        // 20 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(20)),
          const ExtraLiveReward(amount: 2),
        ],
        // 21 lvl
        [const BucksReward(amount: 500)],
        // 22 lvl
        [const BucksReward(amount: 500)],
        // 23 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(23)),
          const ExtraLiveReward(amount: 2),
        ],
        // 24 lvl
        [const BucksReward(amount: 500)],
        // 25 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(25)),
          const ExtraLiveReward(amount: 1),
        ],
        // 26 lvl
        [const BucksReward(amount: 500)],
        // 27 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(27)),
          const ExtraLiveReward(amount: 1),
        ],
        // 28 lvl
        [const BucksReward(amount: 500)],
        // 29 lvl
        [const BucksReward(amount: 500)],
        // 30 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(30)),
          const SkinReward('spider-man'),
          const ExtraLiveReward(amount: 1),
        ],
        // 31 lvl
        [const BucksReward(amount: 500)],
        // 32 lvl
        [const BucksReward(amount: 500)],
        // 33 lvl
        [
          const BucksReward(amount: 500),
          RankReward(rank: rankFromLvl(33)),
          const ExtraLiveReward(amount: 1),
        ],
        // 34 lvl
        [const BucksReward(amount: 500)],
        // 35 lvl
        [
          const BucksReward(amount: 1000),
          RankReward(rank: rankFromLvl(35)),
          const ExtraLiveReward(amount: 1),
        ],
      ];
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
    item: Items.homeless,
    exp: 2,
    value: 2,
  ),
];
