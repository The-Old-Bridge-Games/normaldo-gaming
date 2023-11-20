import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';

sealed class MissionsFailure implements Exception {
  @override
  String toString() => switch (this) {
        MissionsUnknownFailure() => (this as MissionsUnknownFailure).error,
      };
}

final class MissionsUnknownFailure extends MissionsFailure {
  MissionsUnknownFailure(this.error);

  final String error;
}

abstract interface class MissionsRepository {
  Future<void> save({required List<Mission> missions});
  Future<void> saveProgress({required Map<Mission, int> progress});

  Future<List<Mission>?> fetchMissions();
  Future<Map<Mission, int>?> fetchProgress();
}
