import 'package:json_annotation/json_annotation.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';

part 'mission_model.g.dart';

@JsonSerializable()
final class MissionModel {
  MissionModel({
    required this.type,
    required this.description,
    required this.exp,
    required this.isOneGame,
    required this.value,
    required this.completed,
    this.item,
  }) : assert(type == MissionType.crashItem ? item != null : item == null);

  MissionModel.fromEntity(Mission mission)
      : type = mission.type,
        description = mission.description,
        exp = mission.exp,
        isOneGame = mission.isOneGame,
        value = mission.value,
        completed = mission.completed {
    if (mission.type == MissionType.crashItem) {
      item = (mission as CrashItemInOneGameMission).item;
    }
  }

  final MissionType type;
  final String description;
  final int exp;
  final bool isOneGame;
  final int value;
  bool completed;
  Items? item;

  Mission toEntity() => switch (type) {
        MissionType.collectPizza => CollectPizzaInOneGameMission(
            exp: exp,
            value: value,
            completed: completed,
          ),
        MissionType.crashItem => CrashItemInOneGameMission(
            exp: exp,
            value: value,
            item: item!,
          ),
        MissionType.finishGame => FinishGameAtLevelMission(
            exp: exp,
            description: description,
            value: value,
            completed: completed,
          )
      };

  factory MissionModel.fromJson(Map<String, dynamic> json) =>
      _$MissionModelFromJson(json);
  Map<String, dynamic> toJson() => _$MissionModelToJson(this);
}
