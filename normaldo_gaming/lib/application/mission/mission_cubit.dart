import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/pull_up_game/missions/missions_repository.dart';

part 'mission_state.dart';
part 'mission_cubit.freezed.dart';

class MissionCubit extends HydratedCubit<MissionState> {
  final UserCubit _userCubit;
  final MissionsRepository _missionsRepository;

  MissionCubit(this._userCubit, this._missionsRepository)
      : super(MissionState.initial());

  void applyProgress(
    MissionType type, {
    Items? item,
    int? currentLocationIndex,
  }) {
    return;
    if (!_hasMissionOfType(type)) return;
    if ((type == MissionType.crashItem || type == MissionType.passItem) &&
        item == null) {
      throw UnexpectedError();
    }
    if (type == MissionType.finishGame && currentLocationIndex == null) {
      throw UnexpectedError();
    }

    final mission = _missionOfType(type);
    mission.maybeWhen(
      finishGame: (exp, description, adsViewed, completeValue, isOneGame, type,
          currentValue) {
        if (!mission.completed) {
          if ((currentLocationIndex ?? 0) < completeValue) {
            return;
          } else {
            if (!mission.completed) {
              final start = state.missions.toList().indexOf(mission) - 1;
              final end = state.missions.toList().indexOf(mission) + 1;
              final replacements = [
                mission.copyWith(currentValue: completeValue)
              ];
              final newMissions = List<Mission>.from(state.missions)
                ..replaceRange(start, end, replacements);
              emit(state.copyWith(missions: newMissions.toSet()));
            }
          }
        }
      },
      orElse: () {},
    );
    if (!mission.completed) {
      final start = state.missions.toList().indexOf(mission) - 1;
      final end = state.missions.toList().indexOf(mission) + 1;
      final replacements = [
        mission.copyWith(currentValue: mission.currentValue + 1)
      ];
      final newMissions = List<Mission>.from(state.missions)
        ..replaceRange(start, end, replacements);
      emit(state.copyWith(missions: newMissions.toSet()));
    }
  }

  void addAdView(MissionType type) {
    if (!_hasMissionOfType(type)) return;

    final mission = _missionOfType(type);
    if (!mission.completed) {
      final start = state.missions.toList().indexOf(mission) - 1;
      final end = state.missions.toList().indexOf(mission) + 1;
      final replacements = [
        mission.copyWith(currentValue: mission.adsViewed + 1)
      ];
      final newMissions = List<Mission>.from(state.missions)
        ..replaceRange(start, end, replacements);
      emit(state.copyWith(missions: newMissions.toSet()));
      rearrangeCompletedMissions();
    }
  }

  void rearrangeCompletedMissions() {
    if (state.missions.every((element) => !element.completed) &&
        state.missions.isNotEmpty) return;

    for (final completedMission in state.missions) {
      _userCubit.addExp(completedMission.exp);
    }

    final newMissions = List<Mission>.from(state.missions)
      ..removeWhere((element) => element.completed);
    final restAmount = 3 - newMissions.length;
    newMissions.addAll(_missionsRepository.generateMissionsOfType(
      amount: restAmount,
      excludeTypes: newMissions.map((e) => e.type).toSet(),
    ));
    emit(state.copyWith(missions: newMissions.toSet()));
  }

  // <––––––––––––––––––––––––– PRIVATE METHODS –––––––––––––––––––––––––>

  bool _hasMissionOfType(MissionType type) {
    return state.missions.any((element) => element.type == type);
  }

  Mission _missionOfType(MissionType type) =>
      state.missions.firstWhere((element) => element.type == type,
          orElse: () => throw UnexpectedError());

  // <––––––––––––––––––––––––– HYDRATING –––––––––––––––––––––––––>

  @override
  MissionState? fromJson(Map<String, dynamic> json) {
    final missionsList = json['missions'] as List?;
    if (missionsList == null) return null;
    final missions = missionsList.map((e) => Mission.fromJson(e)).toSet();
    return MissionState(missions: missions);
  }

  @override
  Map<String, dynamic>? toJson(MissionState state) {
    return {
      'missions': state.missions.toList().map((e) => e.toJson()).toList()
    };
  }
}
