part of 'missions_cubit.dart';

@freezed
class MissionsState with _$MissionsState {
  const factory MissionsState.initial() = _Initial;
  const factory MissionsState.loading() = _Loading;
  const factory MissionsState.failed({required MissionsFailure failure}) =
      _Failed;
  const factory MissionsState.success({
    required Map<Mission, int> progress,
  }) = _Success;
  const factory MissionsState.replaced({
    required (int index, Mission newMission) replacement,
  }) = _Replaced;
}

@freezed
class MissionsState2 with _$MissionsState2 {
  const factory MissionsState2({
    required bool loading,
    required List<Mission> missions,
    required List<Mission> completed,
    MissionsFailure? failure,
  }) = _MissionsState2;

  factory MissionsState2.initial() => const MissionsState2(
        loading: false,
        missions: [],
        completed: [],
      );
}
