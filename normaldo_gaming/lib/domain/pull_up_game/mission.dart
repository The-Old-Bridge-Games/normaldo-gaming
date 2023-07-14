import 'items.dart';

sealed class Mission {
  final String description;
  final int exp;
  final bool isOneGame;
  bool completed;

  Mission({
    required this.description,
    required this.exp,
    required this.isOneGame,
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
    required this.pizzaCount,
  }) : super(
            isOneGame: true,
            description: 'Collect $pizzaCount pizzas in one game');

  final int pizzaCount;

  @override
  MissionType get type => MissionType.collectPizza;
}

final class CrashItemInOneGameMission extends Mission {
  CrashItemInOneGameMission({
    required super.exp,
    required this.count,
    required this.item,
  }) : super(
            isOneGame: true,
            description: 'Crash $count ${item.name} in one game');

  final int count;
  final Items item;

  @override
  MissionType get type => MissionType.crashItem;
}

final class FinishGameAtLevelMission extends Mission {
  FinishGameAtLevelMission({
    required super.exp,
    required super.description,
    required this.level,
  }) : super(
          isOneGame: true,
        );

  final int level;

  @override
  MissionType get type => MissionType.finishGame;
}
