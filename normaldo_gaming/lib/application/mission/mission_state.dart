part of 'mission_cubit.dart';

@freezed
class MissionState with _$MissionState {
  const factory MissionState({
    required Set<Mission> missions,
  }) = _MissionState;

  factory MissionState.initial() => MissionState(missions: const {});
}
