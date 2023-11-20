import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/pull_up_game/missions/missions_repository.dart';

part 'missions_state.dart';
part 'missions_cubit.freezed.dart';

/**
 * Сделать кубит как контроллер к аниматед листу, то есть просто переписать
 * его функции сюда и связать с виджетом как контроллер
 * 1. init (load missions as it as with progress)
 * 2. insertMission
 * 3. removeMission
 */

class MissionsCubit extends Cubit<MissionsState2> {
  MissionsCubit(this._repository) : super(MissionsState2.initial());

  final MissionsRepository _repository;
  final _rnd = Random();

  bool _initialized = false;

  var _progress = <Mission, int>{};

  int? progressOf(Mission mission) {
    return _progress[mission];
  }

  List<Mission> get missions => List.from(_progress.keys);

  final _firstMissions = [
    CollectPizzaInOneGameMission(
      exp: 1,
      value: 15,
    ),
    CrashItemInOneGameMission(
      item: Items.trashBin,
      exp: 2,
      value: 1,
    ),
    FinishGameAtLevelMission(
      description: 'End game before exiting the lair'.tr(),
      exp: 1,
      value: 0,
    ),
  ];

  // <––––––––––––––––––––––––– MISSIONS CUBIT 2 –––––––––––––––––––––––––>

  Future<void> init() async {
    emit(state.copyWith(loading: false));
    try {
      final missions = await _repository.fetchMissions();
      if (_progress.isEmpty) {
        _progress = missions == null
            ? Map.fromIterable(_firstMissions, value: (_) => 0)
            : Map.fromIterable(missions, value: (_) => 0);
      }
      _initialized = true;
      emit(state.copyWith(
        loading: false,
        missions: missions ?? _firstMissions,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        failure: MissionsUnknownFailure(e.toString()),
      ));
    }
  }

  Future<void> rebuild() async {}

  // <––––––––––––––––––––––––– MISSIONS CUBIT 1 –––––––––––––––––––––––––>

  // Future<void> loadMissions() async {
  //   emit(const MissionsState.loading());
  //   try {
  //     final missions = await _repository.fetchMissions();
  //     if (_progress.isEmpty) {
  //       _progress = missions == null
  //           ? Map.fromIterable(_firstMissions, value: (_) => 0)
  //           : Map.fromIterable(missions, value: (_) => 0);
  //     }
  //     emit(MissionsState.success(
  //       progress: _progress,
  //     ));
  //     _checkCompleted(this.missions);
  //   } catch (e) {
  //     emit(MissionsState.failed(failure: MissionsUnknownFailure(e.toString())));
  //   }
  // }

  // Future<void> checkCompletion() async {
  //   _checkCompleted(missions);
  // }

  // Future<void> complete(List<Mission> missions, int completedIndex) async {
  //   final newMission = _getNewMission(missions: missions);
  //   emit(MissionsState.replaced(replacement: (completedIndex, newMission)));
  //   final newMissions = List<Mission>.from(missions)..removeAt(completedIndex);
  //   newMissions.insert(completedIndex, newMission);
  //   _progress.remove(missions[completedIndex]);
  //   _progress[newMission] = 0;
  //   _repository.save(missions: newMissions);
  // }

  // void checkState({required GameSessionState state}) {
  //   for (final mission in _progress.keys) {
  //     if (mission.completed) continue;
  //     switch (mission) {
  //       case CollectPizzaInOneGameMission():
  //         if (state.score == mission.value) {
  //           mission.completed = true;
  //         } else {
  //           _progress[mission] = state.score;
  //         }
  //       case FinishGameAtLevelMission():
  //         if (state.level == mission.value && state.isDead) {
  //           complete(missions, missions.indexOf(mission));
  //         }
  //       default:
  //         continue;
  //     }
  //   }
  // }

  // void checkHit({required Items hitItem}) {
  //   final crashMissions = _progress.keys
  //       .where((element) => element.type == MissionType.crashItem);
  //   if (crashMissions.isEmpty) return;

  //   for (final mission in crashMissions) {
  //     if (mission.completed) return;
  //     if ((mission as CrashItemInOneGameMission).item == hitItem) {
  //       _progress[mission] = (_progress[mission] ?? 0) + 1;
  //       if (_progress[mission] == mission.value) {
  //         mission.completed = true;
  //       }
  //     }
  //   }
  // }

  // void _checkCompleted(List<Mission> missions) {
  //   for (final mission in missions) {
  //     if (mission.completed) {
  //       final indexOfMission = missions.indexOf(mission);
  //       final newMission = _getNewMission(missions: missions);
  //       final newMissions = List<Mission>.from(missions)
  //         ..removeAt(indexOfMission);
  //       newMissions.insert(indexOfMission, newMission);
  //       _progress = Map.fromIterable(newMissions, value: (_) => 0);
  //       _repository.save(missions: newMissions);
  //       emit(MissionsState.replaced(replacement: (indexOfMission, newMission)));
  //     }
  //   }
  // }

  // Mission _getNewMission({required List<Mission> missions}) {
  //   final allMissionsExcept = List.from(_allMissions);
  //   Mission mission = allMissionsExcept[_rnd.nextInt(allMissionsExcept.length)];
  //   return mission;
  // }
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
