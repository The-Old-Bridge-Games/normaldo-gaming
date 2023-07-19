import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';

abstract interface class MissionsRepository {
  Future<void> save({required List<Mission> missions});
  Future<void> saveProgress({required Map<Mission, int> progress});

  Future<List<Mission>?> fetchMissions();
  Future<Map<Mission, int>?> fetchProgress();
}
