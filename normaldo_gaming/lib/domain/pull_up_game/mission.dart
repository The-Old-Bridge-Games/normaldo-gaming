import 'items.dart';

sealed class Mission {
  final String description;
  final int exp;
  final bool isOneGame;
  final int value;
  bool completed;

  Mission({
    required this.description,
    required this.exp,
    required this.isOneGame,
    required this.value,
    this.completed = false,
  });

  MissionType get type;
}

enum MissionType {
  collectPizza,
  crashItem,
  finishGame;
}

final class CollectPizzaInOneGameMission extends Mission {
  CollectPizzaInOneGameMission({
    required super.exp,
    required super.value,
    super.completed,
  }) : super(isOneGame: true, description: 'Collect $value pizzas in one game');

  @override
  MissionType get type => MissionType.collectPizza;
}

final class CrashItemInOneGameMission extends Mission {
  CrashItemInOneGameMission({
    required super.exp,
    required super.value,
    required this.item,
    super.completed,
  }) : super(
            isOneGame: true,
            description: 'Crash $value ${item.name} in one game');

  final Items item;

  @override
  MissionType get type => MissionType.crashItem;
}

final class FinishGameAtLevelMission extends Mission {
  FinishGameAtLevelMission({
    required super.exp,
    required super.description,
    required super.value,
    super.completed,
  }) : super(
          isOneGame: true,
        );

  @override
  MissionType get type => MissionType.finishGame;
}
