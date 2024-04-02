part of 'mission_cubit.dart';

@freezed
class MissionState with _$MissionState {
  const factory MissionState({
    required Set<Mission> missions,
    required bool completing,
    required List<int> newIndexes,
  }) = _MissionState;

  factory MissionState.initial() => const MissionState(
        missions: {},
        completing: false,
        newIndexes: [],
      );
}
