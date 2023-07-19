import 'package:hive/hive.dart';
import 'package:normaldo_gaming/data/pull_up_game/missions/models/mission_model.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/domain/pull_up_game/missions/missions_repository.dart';
import 'package:path_provider/path_provider.dart';

class LocalMissionsRepository implements MissionsRepository {
  Future<String>? get path async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _openBox(String name) async {
    await Hive.openBox(name, path: await path);
  }

  @override
  Future<List<Mission>?> fetchMissions() async {
    final boxExists = await Hive.boxExists('missions', path: await path);
    if (boxExists) {
      final isBoxOpen = Hive.isBoxOpen('missions');
      if (!isBoxOpen) await _openBox('missions');
      final box = Hive.box('missions');
      final list = box.get('current') as List?;
      if (list != null) {
        final missionModelsMap = list.map((e) {
          final map = (e as Map<dynamic, dynamic>)
              .map((key, value) => MapEntry(key.toString(), value));
          return map;
        }).toList();
        final missionModels =
            missionModelsMap.map((e) => MissionModel.fromJson(e));
        final missions = missionModels.map((e) => e.toEntity()).toList();
        return missions;
      }
    } else {
      await _openBox('missions');
      return fetchMissions();
    }
    return null;
  }

  @override
  Future<void> save({required List<Mission> missions}) async {
    final boxExists = await Hive.boxExists('missions', path: await path);
    if (boxExists) {
      final isBoxOpen = Hive.isBoxOpen('missions');
      if (!isBoxOpen) await _openBox('missions');
      final box = Hive.box('missions');
      final missionsJson =
          missions.map((e) => MissionModel.fromEntity(e).toJson()).toList();
      await box.put('current', missionsJson);
    } else {
      await _openBox('missions');
      return save(missions: missions);
    }
  }

  @override
  Future<void> saveProgress({required Map<Mission, int> progress}) async {
    final boxExists = await Hive.boxExists('progress', path: await path);
    if (boxExists) {
      final isBoxOpen = Hive.isBoxOpen('progress');
      if (!isBoxOpen) await _openBox('progress');
      final box = Hive.box('progress');
      final map = progress.map((key, value) =>
          MapEntry(MissionModel.fromEntity(key).toJson(), value));
      await box.put('progress', map);
    } else {
      await _openBox('progress');
      return saveProgress(progress: progress);
    }
  }

  @override
  Future<Map<Mission, int>?> fetchProgress() async {
    final boxExists = await Hive.boxExists('progress', path: await path);
    if (boxExists) {
      final isBoxOpen = Hive.isBoxOpen('progress');
      if (!isBoxOpen) await _openBox('progress');
      final box = Hive.box('progress');
      final map = box.get('current') as Map<Map<String, dynamic>, int>?;
      if (map != null) {
        return map.map((key, value) =>
            MapEntry(MissionModel.fromJson(key).toEntity(), value));
      }
    } else {
      await _openBox('progress');
      return fetchProgress();
    }
    return null;
  }
}
